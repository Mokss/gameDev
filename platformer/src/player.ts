import type { Position } from './types';

export interface IPlayer {
	canvas: HTMLCanvasElement;
	context: CanvasRenderingContext2D;
    position: Position;
	velocity: Position;
	height: number;
}

export interface PlayerProps{
	canvas: HTMLCanvasElement;
    position: Position;
	velocity?: Position;
}

const gravity = 0.5;

export class Player implements IPlayer {
	canvas: IPlayer['canvas'];
	context: IPlayer['context'];
	position: IPlayer['position'];
	velocity: IPlayer['velocity'];
	height = 100;

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
		this.context.fillRect(this.position.x, this.position.y, 100, this.height);
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