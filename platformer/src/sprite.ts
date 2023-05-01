import type { Position } from './types';

export interface ISprite {
    position: Position;
    canvas: HTMLCanvasElement;
	context: CanvasRenderingContext2D;
    image: HTMLImageElement
}

export interface SpiteProps{
	canvas: HTMLCanvasElement;
    position: Position;
    src: string;
}

export class Sprite implements ISprite {
	canvas: ISprite['canvas'];
	context: ISprite['context'];
	position: ISprite['position'];
	image: ISprite['image'];

	constructor(props: SpiteProps) {
		this.canvas = props.canvas;
		this.context = props.canvas.getContext('2d') as CanvasRenderingContext2D;
		this.position = props.position;
		this.image = new Image();
		this.image.src = props.src; 
	}

	draw() {
		this.context.drawImage(this.image, this.position.x, this.position.y) ;
	}

	update() {
		this.draw();
	}
}