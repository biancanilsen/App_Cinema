import { Column, Entity, JoinTable, ManyToMany, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { MovieEntity } from "../movie/movie.entity";

@Entity()
export class HourlyEntity {

    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column()
    timeDay: string;

    @Column()
    date: Date;

    @ManyToOne(() => MovieEntity, movie => movie.Hourly, { orphanedRowAction: 'delete' })
    Movie: MovieEntity;
}