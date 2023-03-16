import { HourlyEntity } from "../../hourly/hourly.entity";

export default class TesteHourly {
    static validHourly(): HourlyEntity {
        const hourly = new HourlyEntity();
        hourly.id = "4c32b9f6-a402-4663-97f5-524842bc98f0",
            hourly.timeDay = "13:30",
            hourly.date = new Date('2022/04/02'),
            hourly.Movie = {
                id: "0fc7cfa7-9749-4ffb-b7ce-21b9731e2ff3",
                name: 'valid@gmail.com',
                classification: 1,
                type: 2,
                duration: '01:30',
                room: 5,
                path: 'bomdia',
                Hourly: [hourly]
            }

        return hourly;
    }
}