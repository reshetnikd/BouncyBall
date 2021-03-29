import Foundation

let ball = OvalShape(width: 40, height: 40)

let barrierWidth = 300.0
let barrierHeight = 25.0

let barrierPoints = [
    Point(x: 0, y: 0),
    Point(x: 0, y: barrierHeight),
    Point(x: barrierWidth, y: barrierHeight),
    Point(x: barrierWidth, y: 0)
]

let barrier = PolygonShape(points: barrierPoints)

let funnelPoints = [
    Point(x: 0, y: 50),
    Point(x: 80, y: 50),
    Point(x: 60, y: 0),
    Point(x: 20, y: 0)
]

let funnel = PolygonShape(points: funnelPoints)

let targetPoints = [
    Point(x: 10, y: 0),
    Point(x: 0, y: 10),
    Point(x: 10, y: 20),
    Point(x: 20, y: 10)
]

let target = PolygonShape(points: targetPoints)

/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

fileprivate func setupBall() {
    ball.position = Point(x: 250, y: 400)
    ball.hasPhysics = true
    ball.isDraggable = false
    ball.fillColor = .blue
    ball.onCollision = ballCollided(with:)
    ball.onExitedScene = ballExitedScene
    ball.onTapped = resetGame
    scene.add(ball)
    scene.trackShape(ball)
}

fileprivate func setupBarrier() {
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    barrier.isImmobile = true
    barrier.fillColor = .brown
    scene.add(barrier)
}

fileprivate func setupFunnel() {
    funnel.position = Point(x: 200, y: scene.height - 25)
    funnel.isDraggable = false
    funnel.onTapped = dropBall
    funnel.fillColor = .gray
    scene.add(funnel)
}

fileprivate func setupTarget() {
    target.position = Point(x: 200, y: 400)
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = true
    target.isDraggable = false
    target.fillColor = .yellow
    target.name = "target"
    scene.add(target)
}

func setup() {
    setupBall()
    
    // Add a barrier to the scene.
    setupBarrier()
    
    // Add a funnel to the scene.
    setupFunnel()
    
    // Add a target to the scene.
    setupTarget()
    
    resetGame()
}

// Drops the ball by moving it to the funnel's position.
func dropBall() {
    ball.position = funnel.position
    ball.stopAllMotion()
    barrier.isDraggable = false
}

// Handles collisions between the ball and the targets.
func ballCollided(with otherShape: Shape) {
    if otherShape.name != "target" { return }
    
    otherShape.fillColor = .green
}

func ballExitedScene() {
    barrier.isDraggable = true
}

// Resets the game by moving the ball below the scene, which will unlock the barriers.
func resetGame() {
    ball.position = Point(x: 0, y: -80)
}
