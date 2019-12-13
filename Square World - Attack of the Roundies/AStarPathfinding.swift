//
//  AStarPathfinding.swift
//  Square World - Attack of the Roundies
//
//  Created by Michael Wolf on 25/11/2019.
//  Copyright © 2019 Michael Wolf. All rights reserved.
//

import Foundation

protocol PathfinderDataSource: NSObjectProtocol {
    func walkableAdjacentTilesCoordsForTileCoord(tileCoord: TileCoord) -> [TileCoord]
    func costToMoveFromTileCoord(fromTileCoord: TileCoord, toAdjacentTileCoord toTileCoord: TileCoord) -> Int
}

/** A pathfinder based on the A* algorithm to find the shortest path between two locations */
class AStarPathfinder {
    weak var dataSource: PathfinderDataSource?
    
    func shortestPathFromTileCoord(fromTileCoord: TileCoord, toTileCoord: TileCoord) -> [TileCoord]? {
        // placeholder: move immediately to the destination coordinate
        return [toTileCoord]
    }
}
