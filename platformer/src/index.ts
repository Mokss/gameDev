import { CollisionBlock } from './classes/collisionBlock.js';
import { Player } from './classes/player.js';
import { Sprite } from './classes/sprite.js';
import { floorCollisions, platformCollisions } from './data/collisions.js';

const canvas =  document.querySelector('canvas') as HTMLCanvasElement;
const context = canvas.getContext('2d') as CanvasRenderingContext2D;

canvas.width = 1024;
canvas.height = 576;

const scaledCanvas = {
	width: canvas.width / 4,
	height: canvas.height / 4
};

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
				}
			}));
		}
	}); 
});




const player = new Player({ 
	context,
	src: './assets/warrior/Idle.png',
	position: { x: 0, y: 0 },
	collisionBlocks,
	frameRate: 8,
	frameBuffer: 6,
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

function animate() {
	window.requestAnimationFrame(animate); 

	context.save();
	context.scale(4, 4);
	context.translate(0, -background.image.height + scaledCanvas.height);
	background.update();
	collisionBlocks.forEach(block => block.update());
	platformCollisionBlocks.forEach(block => block.update());

	player.update();

	player.velocity.x = 0;
	if (keys.right.pressed) player.velocity.x = 5;
	else if (keys.left.pressed) player.velocity.x = -5;

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
			player.velocity.y = -8;
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