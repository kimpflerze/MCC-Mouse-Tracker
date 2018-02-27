export class IOrder {
    public Id: string
    public Lab: string;
    public Protocol: number;
    public PrincipalInvestigator: string;
    public Charged: string;
    public DeliveryDate: Date;
    public MaleMice: number;
    public FemaleMice: number;
    public Gender: number;
    public MinimumAge: number;
    public MaximumAge: number;
    public Address: string;
    public Room: string;

    constructor() {
        this.Lab = null;
        this.Protocol = null;
        this.PrincipalInvestigator = null;
        this.DeliveryDate = null;
        this.MaleMice = null;
        this.FemaleMice = null;
        this.Room = null;
    }
}