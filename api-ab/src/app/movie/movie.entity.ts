import { Column, CreateDateColumn, DeleteDateColumn, Entity, JoinTable, ManyToMany, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { HourlyEntity } from "../hourly/hourly.entity";
import { Classification } from "./enum/classification.enum";
import { Type } from "./enum/type.enum";

@Entity()
export class MovieEntity {

    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column()
    name: string;

    @Column()
    classification: Classification;

    @Column()
    type: Type;


    @Column()
    duration: string;

    @Column()
    room: number

    @Column({ nullable: true })
    path: string;

    @OneToMany(() => HourlyEntity, (hourly) => hourly.Movie, {
        cascade: ['insert', 'update', 'remove'],
        orphanedRowAction: 'delete',
    })
    Hourly: HourlyEntity[];

    @CreateDateColumn({ type: 'timestamptz' })
    createdAt?: Date;

    @UpdateDateColumn({ type: 'timestamptz' })
    updatedAt?: Date;

    @DeleteDateColumn({ type: 'timestamptz' })
    deletedAt?: Date;
}