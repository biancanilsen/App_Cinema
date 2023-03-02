import { IsOptional } from "class-validator";
import { Classification } from "../enum/classification.enum";
import { Type } from "../enum/type.enum";

export class UpdateMovieDto {

    @IsOptional()
    name: string;

    @IsOptional()
    classification: Classification;

    @IsOptional()
    type: Type;

    @IsOptional()
    duration: string;

    @IsOptional()
    room: number

}