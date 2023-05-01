import { Player } from './player.js';

const canvas =  document.querySelector('canvas') as HTMLCanvasElement;
const context = canvas.getContext('2d') as CanvasRenderingContext2D;

canvas.width = document.body.clientWidth;
canvas.height = document.body.clientHeight;

const player = new Player({ canvas , position: { x:0, y: 0 }});
const player2 = new Player({ canvas , position: { x: 300, y: 100 }});

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

	context.fillStyle = 'white';
	context.fillRect(0, 0, canvas.width, canvas.height);

	player.update();
	player2.update();

	player.velocity.x = 0;
	if (keys.right.pressed) player.velocity.x = 5;
	else if (keys.left.pressed) player.velocity.x = -5;
}

animate();

window.addEventListener('keydown', (event) => {
	console.log('keydown', event.code);
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
			player.velocity.y = -15;
			break;
		default:
			break;
	}
});

window.addEventListener('keyup', (event) => {
	console.log('keyup', event.code);
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
		case 'ArrowUp':
			player.velocity.y = -15;
			break;
		default:
			break;
	}
});