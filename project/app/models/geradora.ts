import type { Tecnologia } from "../enums/tecnologia";
import type { Contrato } from "../enums/contrato";
import type { Comprador } from "../enums/comprador";
import type { Municipio } from "./municipio";
import type { Equipamento } from "./equipamento";

export class Geradora{
    id!: number;
    tecnologia!: Tecnologia;
    contrato!: Contrato;
    comprador!: Comprador;
    municipio!: Municipio;
    equipamento!: Equipamento[];
    dataInicoOperacao!: Date;
    dataInicioColeta!: Date;
    potenciaInstaladaKw!: number;
    capacidadeInstaladaKw!: number;
    mediaEnergiaGeradaMensal!: number;
    mediaEnergiaGeradaAnual!: number;
    reducaoCo2Anual!: number;
}       