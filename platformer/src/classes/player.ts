import { gravity } from '../constants.js';
import type { Position } from '../types';

export interface PlayerProps{
	canvas: HTMLCanvasElement;
    position: Position;
	velocity?: Position;
}

export class Player {
	canvas:  HTMLCanvasElement;
	context: CanvasRenderingContext2D;
	position: Position;
	velocity: Position;
	height = 100;
	width = 100;

	constructor(props: PlayerProps) {
		this.canvas = props.canvas;
		this.context = props.canvas.getContext('2d') as CanvasRenderingContext2D;
		this.position = props.position;
		this.velocity = props.velocity || {
			x: 0,
			y: 1,
		};
	}

	draw() {
		this.context.fillStyle = 'red';
		this.context.fillRect(this.position.x, this.position.y, this.width, this.height);
	}

	update() {
		this.draw();
		this.position.x += this.velocity.x;
		this.position.y += this.velocity.y;

		const currentPosition = this.position.y + this.height + this.velocity.y;
		if (currentPosition < this.canvas.height) {
			this.velocity.y += gravity;
		} else {
			this.position.y = this.canvas.height - this.height;
			this.velocity.y = 0;
		}
	}
}