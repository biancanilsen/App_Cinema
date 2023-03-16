import { Column, CreateDateColumn, DeleteDateColumn, Entity, JoinTable, ManyToMany, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
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

    @CreateDateColumn({ type: 'timestamptz' })
    createdAt?: Date;

    @UpdateDateColumn({ type: 'timestamptz' })
    updatedAt?: Date;

    @DeleteDateColumn({ type: 'timestamptz' })
    deletedAt?: Date;
}