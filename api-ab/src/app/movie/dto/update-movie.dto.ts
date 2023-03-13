import { ApiProperty } from "@nestjs/swagger";
import { IsOptional } from "class-validator";
import { Classification } from "../enum/classification.enum";
import { Type } from "../enum/type.enum";

export class UpdateMovieDto {

    @IsOptional()
    @ApiProperty({ type: String })
    name: string;

    @IsOptional()
    @ApiProperty({ enum: ['free', 'forAges10AndUp', 'forAges12AndUp', 'forAges14AndUp', 'forAges16AndUp', 'forAges18AndUp'] })
    classification: Classification;

    @IsOptional()
    @ApiProperty({ enum: ['dubbed', 'subtitled'] })
    type: Type;

    @IsOptional()
    @ApiProperty({ type: String })
    duration: string;

    @IsOptional()
    @ApiProperty({ type: Number })
    room: number

    @IsOptional()
    @ApiProperty({ type: String })
    path: string;

}