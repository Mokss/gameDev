export type Position = {
	x: number;
	y: number;
}

export type Size = {
	width: number;
	height: number;
}

export type Block = {
	position: Position;
} & Size

export type Animations<T> = Record<keyof T, {
	src: string;
	frameRate: number;
	frameBuffer: number;
	img?: HTMLImageElement;
}>