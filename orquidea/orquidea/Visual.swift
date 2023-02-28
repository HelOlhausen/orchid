//
//  Sketch.swift
//  orquidea
//
//  Created by Helen Olhausen on 02/01/23.
//

import UIKit
import SwiftProcessing

class Visual: Sketch, SketchDelegate {
    var centerX: Double = 0.0
    var centerY: Double = 0.0
    
    var formResolution = 15
    var stepSize = 0
    var initRadius = 150
    var x: [Double] = []
    var y: [Double] = []

    var filled = false
    var freeze = false
    var drawMode = 1
    
    func setup() {
      // init shape
        centerX = width / 2.0
        centerY = height / 2.0
      let angle = radians(360 / formResolution)
      for i in 0...formResolution {
        x.append(cos(angle * i) * initRadius);
        y.append(sin(angle * i) * initRadius);
      }

      stroke(240, 50)
      strokeWeight(0.75)
    }
    
    func draw() {
        // floating towards mouse position
        centerX += (random(1000) - centerX) * 0.01;
        centerY += (random(1000) - centerY) * 0.01;

        // calculate new points
        for i in 0...formResolution {
            x[i] += random(-stepSize, stepSize)
            y[i] += random(-stepSize, stepSize)
        }

        if filled {
          fill(random(255))
        } else {
          noFill()
        }

        switch drawMode {
        case 1: // circle
          beginShape();
          // start controlpoint
          curveVertex(x[formResolution - 1] + centerX, y[formResolution - 1] + centerY);

          // only these points are drawn
          for i in 0...formResolution {
            curveVertex(x[i] + centerX, y[i] + centerY);
          }
          curveVertex(x[0] + centerX, y[0] + centerY);

          // end controlpoint
          curveVertex(x[1] + centerX, y[1] + centerY);
          endShape()
          
        case 2: // line
          beginShape();
          // start controlpoint
          curveVertex(x[0] + centerX, y[0] + centerY);

          // only these points are drawn
          for i in 0...formResolution {
            curveVertex(x[i] + centerX, y[i] + centerY);
          }

          // end controlpoint
          curveVertex(x[formResolution - 1] + centerX, y[formResolution - 1] + centerY);
          endShape()
         
        default:
            break
        }
    }
}
