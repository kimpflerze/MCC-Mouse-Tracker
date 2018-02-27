export interface IAlert {
    AlertId: string,
    AlertTypeId: number
    AlertType: IAlertType,
    SubjectId: string,
    AlertDate: Date
}

export interface IAlertType {
    Id: string,
    Description: string
}