package com.example.app.entities

import org.opencv.core.Point

enum class Cities(_name: String, val location: Array<Int>) {
    Edinburgh("Edinburgh",arrayOf(499, 1819)),
    Lisbon("Lisbon",arrayOf(138, 273)),
    Madrid("Madrid",arrayOf(331, 338)),
    Cadiz("Cadiz",arrayOf(325, 125)),
    Barcelona("Barcelona",arrayOf(649, 310)),
    Pamplona("Pamplona",arrayOf(617, 574)),
    Paris("Paris",arrayOf(799, 1008)),
    Dieppe("Dieppe",arrayOf(660, 1134)),
    Brest("Brest",arrayOf(403, 1051)),
    London("London",arrayOf(691, 1391)),
    Amsterdam("Amsterdam",arrayOf(964, 1379)),
    Brussels("Brussels",arrayOf(901, 1246)),
    Zurich("Zurich",arrayOf(1125, 852)),
    Marseille("Marseille",arrayOf(1048, 586)),
    Palermo("Palermo",arrayOf(1489, 132)),
    Rome("Rome",arrayOf(1383, 505)),
    Venice("Venice",arrayOf(1361, 759)),
    Munich("Munich",arrayOf(1314, 1032)),
    Frankfurt("Frankfurt",arrayOf(1150, 1155)),
    Essen("Essen",arrayOf(1194, 1355)),
    Berlin("Berlin",arrayOf(1474, 1313)),
    Copenhagen("Copenhagen",arrayOf(1397, 1654)),
    Stockholm("Stockholm",arrayOf(1688, 1873)),
    Danzig("Danzig",arrayOf(1799, 1534)),
    Vienna("Vienna",arrayOf(1636, 983)),
    Zagreb("Zagreb",arrayOf(1600, 724)),
    Sarajevo("Sarajevo",arrayOf(1840, 560)),
    Brindisi("Brindisi",arrayOf(1627, 432)),
    Athens("Athens",arrayOf(1978, 212)),
    Sofia("Sofia",arrayOf(2029, 536)),
    Smyrna("Smyrna",arrayOf(2221, 137)),
    Ankara("Ankara",arrayOf(2569, 205)),
    Constantinopole("Constantinopole",arrayOf(2345, 363)),
    Erzurm("Erzurm",arrayOf(2802, 272)),
    Sochi("Sochi",arrayOf(2855, 631)),
    Sevastopol("Sevastopol",arrayOf(2595, 675)),
    Bucharest("Bucharest",arrayOf(2203, 716)),
    Rostov("Rostov",arrayOf(2867, 888)),
    Kharkov("Kharkov",arrayOf(2751, 1039)),
    Budapest("Budapest",arrayOf(1773, 913)),
    Kyiv("Kyiv",arrayOf(2365, 1187)),
    Smolensk("Smolensk",arrayOf(2546, 1398)),
    Vilnius("Vilnius",arrayOf(2254, 1408)),
    Warsaw("Warsaw",arrayOf(1934, 1337)),
    Riga("Riga",arrayOf(2032, 1792)),
    Petrograd("Petrograd",arrayOf(2514, 1810)),
    Moscow("Moscow",arrayOf(2793, 1468));

    fun getLocation(): Array<Point>{
        return arrayOf(
            Point(doubleArrayOf(location[1].toDouble()-35,location[0].toDouble()-35)),
            Point(doubleArrayOf(location[1].toDouble()-35,location[0].toDouble()+35)),
            Point(doubleArrayOf(location[1].toDouble()+35,location[0].toDouble()-35)),
            Point(doubleArrayOf(location[1].toDouble()+35,location[0].toDouble()+35))
        )
    }
}