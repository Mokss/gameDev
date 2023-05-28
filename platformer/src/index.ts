import { CollisionBlock } from './classes/collisionBlock.js';
import { Player } from './classes/player.js';
import { Sprite } from './classes/sprite.js';
import { SCALE } from './constants.js';
import { floorCollisions, platformCollisions } from './data/collisions.js';

const canvas =  document.querySelector('canvas') as HTMLCanvasElement;
const context = canvas.getContext('2d') as CanvasRenderingContext2D;

canvas.width = document.body.clientWidth;
canvas.height = document.body.clientHeight;

const floorCollisions2D = [];
for (let i = 0; i < floorCollisions.length; i += 36) {
	floorCollisions2D.push(floorCollisions.slice(i));
}

const collisionBlocks: CollisionBlock[] = [];
floorCollisions2D.forEach((row, y) => {
	row.forEach((symbol, x) => {
		if (symbol === 202) {
			collisionBlocks.push(new CollisionBlock({
				canvas,
				position: {
					x: x * 16,
					y: y * 16,
				}
			}));
		}
	}); 
});

const platformCollisions2D = [];
for (let i = 0; i < platformCollisions.length; i += 36) {
	platformCollisions2D.push(platformCollisions.slice(i));
}

const platformCollisionBlocks: CollisionBlock[] = [];
platformCollisions2D.forEach((row, y) => {
	row.forEach((symbol, x) => {
		if (symbol === 202) {
			platformCollisionBlocks.push(new CollisionBlock({
				canvas,
				position: {
					x: x * 16,
					y: y * 16,
				},
				height: 4
			}));
		}
	}); 
});




const player = new Player({
	context,
	src: './assets/warrior/Idle.png',
	position: { x: 100, y: 340 },
	collisionBlocks,
	platformCollisionBlocks,
	frameRate: 8,
	frameBuffer: 5,
	animations: {
		Idle: {
			src: './assets/warrior/Idle.png',
			frameRate: 8,
			frameBuffer: 5,
		},
		IdleLeft: {
			src: './assets/warrior/IdleLeft.png',
			frameRate: 8,
			frameBuffer: 5,
		},
		Run: {
			src: './assets/warrior/Run.png',
			frameRate: 8,
			frameBuffer: 5,
		},
		RunLeft: {
			src: './assets/warrior/RunLeft.png',
			frameRate: 8,
			frameBuffer: 5,
		},
		Jump: {
			src: './assets/warrior/Jump.png',
			frameRate: 2,
			frameBuffer: 3,
		},
		JumpLeft: {
			src: './assets/warrior/JumpLeft.png',
			frameRate: 2,
			frameBuffer: 3,
		},
		Fall: {
			src: './assets/warrior/Fall.png',
			frameRate: 2,
			frameBuffer: 3,
		},
		FallLeft: {
			src: './assets/warrior/FallLeft.png',
			frameRate: 2,
			frameBuffer: 3,
		},
	}
});

const background = new Sprite({
	context,
	src: './assets/background.png',
	position: {
		x: 0,
		y: 0
	}
});

const keys = {
	right: {
		pressed: false
	},
	left: {
		pressed: false
	},
	top: {
		pressed: false
	}
};

const camera = {
	position: {
		x: 0,
		y: -background.image.height + canvas.height / SCALE,
	}
};

function animate() {
	window.requestAnimationFrame(animate); 

	context.save();
	context.scale(SCALE, SCALE);
	context.translate(camera.position.x, camera.position.y);
	background.update();

	// collisionBlocks.forEach(block => block.update());
	// platformCollisionBlocks.forEach(block => block.update());

	player.checkHorizontalCanvasCollision();
	player.update();

	player.velocity.x = 0;
	if (keys.right.pressed) { 
		player.lastDirection = 'right';
		player.switchSprite('Run');
		player.velocity.x = 2;
		player.shouldPanCameraLeft(canvas, camera);
	} else if (keys.left.pressed) { 
		player.lastDirection = 'left';
		player.switchSprite('RunLeft');
		player.velocity.x = -2;
		player.shouldPanCameraRight(camera);
	} else if (player.velocity.y === 0) {
		player.lastDirection === 'right' ? player.switchSprite('Idle') : player.switchSprite('IdleLeft');
	}

	if (player.velocity.y < 0) {
		player.shouldPanCameraDown(camera);
		player.lastDirection === 'right' ? player.switchSprite('Jump') : player.switchSprite('JumpLeft');
	} else if (player.velocity.y > 0) {
		player.shouldPanCameraUp(canvas, camera);
		player.lastDirection === 'right' ? player.switchSprite('Fall') : player.switchSprite('FallLeft');
	}

	context.restore();
}

animate();

window.addEventListener('keydown', (event) => {
	switch (event.code) {
		case 'KeyD':
		case 'ArrowRight':
			keys.right.pressed = true;
			break;
		case 'KeyA':
		case 'ArrowLeft':
			keys.left.pressed = true;
			break;
		case 'KeyW':
		case 'ArrowUp':
			player.velocity.y = -5;
			break;
		default:
			break;
	}
});

window.addEventListener('keyup', (event) => {
	switch (event.code) {
		case 'KeyD':
		case 'ArrowRight':
			keys.right.pressed = false;
			break;
		case 'KeyA':
		case 'ArrowLeft':
			keys.left.pressed = false;
			break;
		case 'KeyW':
		default:
			break;
	}
});