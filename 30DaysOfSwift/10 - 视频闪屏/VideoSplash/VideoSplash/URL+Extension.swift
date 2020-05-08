//
//  URL+Extension.swift
//  VideoSplash
//
//  Created by TT on 2020/5/8.
//  Copyright © 2020 tTao. All rights reserved.
//

import Foundation
import AVFoundation

extension URL {
    /// 裁剪视频网址
    static func cropVideoWithUrl(videoUrl url: URL, startTime: CGFloat, duration: CGFloat, completion: ((URL?, Error?) -> Void)?) {
        DispatchQueue.global(qos: .default).async {
            let asset = AVURLAsset(url: url)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            guard var outputURL = paths.first else { return }
            
            do {
                try FileManager.default.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("create directory error: \(error.localizedDescription)")
            }
            
            outputURL = outputURL + "/output.mp4"
            
            do {
                try FileManager.default.removeItem(atPath: outputURL)
            } catch let error {
                print("remove item error: \(error.localizedDescription)")
            }
            
            if let es = exportSession {
                es.outputURL = URL(fileURLWithPath: outputURL)
                es.shouldOptimizeForNetworkUse = true
                es.outputFileType = .mp4
                
                let start = CMTime(seconds: Double(startTime), preferredTimescale: 600)
                let duration = CMTime(seconds: Double(duration), preferredTimescale: 600)
                let range = CMTimeRange(start: start, duration: duration)
                
                es.timeRange = range
                
                es.exportAsynchronously {
                    switch es.status {
                    case .completed: completion?(es.outputURL, nil)
                    case .failed: completion?(nil, es.error)
                    case .cancelled: completion?(nil, es.error)
                    default: break
                    }
                }
            }
        }
    }
}
