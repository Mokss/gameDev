import type { Position } from '../types';
export interface SpriteProps {
	context: CanvasRenderingContext2D;
    position: Position;
    src: string;
	scale?: number;
	frameRate?: number
	frameBuffer?: number
}

export class Sprite {
	context: CanvasRenderingContext2D;
	position: Position;
	image: HTMLImageElement;
	width = 0;
	height = 0;
	frameRate: number;
	frameBuffer: number;
	scale: number;
	currentFrame = 0;
	elapsedFrames = 0;
	
	constructor(props: SpriteProps) {
		this.context = props.context;
		this.position = props.position;
		this.scale = props.scale || 1;
		this.image = new Image();
		this.image.onload = () => {
			this.width = Number(this.image.width / this.frameRate) * this.scale;
			this.height = Number(this.image.height) * this.scale;
		};
		this.image.src = props.src; 
		this.frameRate = props.frameRate || 1;
		this.frameBuffer = props.frameBuffer || 3;
	}

	draw() {  
		if (!this.image) return;

		const cronbox = {
			position : {
				x: this.currentFrame * this.image.width / this.frameRate ,
				y: 0,
			},
			width: this.image.width / this.frameRate ,
			height: this.image.height,
		};

		this.context.drawImage(
			this.image,
			cronbox.position.x,
			cronbox.position.y,
			cronbox.width,
			cronbox.height,
			this.position.x,
			this.position.y,
			this.width,
			this.height
		);
	}
 
	update() {
		this.draw();
		this.updateFrames();
	}

	updateFrames() {
		this.elapsedFrames++;
		if (this.elapsedFrames % this.frameBuffer === 0) {
			if (this.currentFrame <  this.frameRate - 1) this.currentFrame++;
			else this.currentFrame = 0;
		}
	}
}