import { NextResponse } from "next/server";
import { prisma } from "@/app/server/db";


export async function GET() {
    const atores = await prisma.ator.findMany();

    // Converter BigInt → String
    const safe = JSON.parse(
        JSON.stringify(atores, (_, value) =>
            typeof value === "bigint" ? value.toString() : value
        )
    );

    return NextResponse.json(safe);
}