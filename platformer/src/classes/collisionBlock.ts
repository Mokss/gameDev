import type { Position } from '../types';
export interface CollisionBlockProps{
	canvas: HTMLCanvasElement;
    position: Position;
	height?: number
}

export class CollisionBlock {
	canvas: HTMLCanvasElement;
	context: CanvasRenderingContext2D;
	position: Position;
	height: number;
	width = 16;

	constructor(props: CollisionBlockProps) {
		this.canvas = props.canvas;
		this.context = props.canvas.getContext('2d') as CanvasRenderingContext2D;
		this.position = props.position;
		this.height = props.height || 16;
	}

	draw() {
		this.context.fillStyle = 'rgba(255, 0, 0, 0.5)';
		this.context.fillRect(this.position.x, this.position.y, this.width, this.height) ;
	}

	update() {
		this.draw();
	}
}