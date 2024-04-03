//
//  WordGenerator.swift
//  SwiftKeysApp
//
//  Created by Frida Dahlqvist on 2024-04-03.
//

import Foundation

class WordGenerator {

    
    let easyLetterWordList = [
        "äpple", "huset", "ocean", "tiger", "plant",
        "stol", "bord", "piano", "ljus", "klock",
        "radio", "citron", "juice", "strand", "borste",
        "musik", "dans", "lycka", "leende", "skratt",
        "hjärta", "frid", "dröm", "magi", "lycka",
        "jätte", "orm", "låga", "storm", "frid", "boll", "hund", "katt",
        "bok", "hus", "näsa", "bär", "fisk", "mjölk", "axel",
        "öra", "peng", "klubb", "väska", "klocka", "hjul", "damm", "lejon", "skor", "vägg",
        "penna", "lampa", "glass", "sol", "fluga", "ring", "snö", "päls", "gräs", "stol",
        "fot", "våg", "häst", "hand", "båt", "bil", "hatt", "spik", "bana", "sax", "ögon",
        "träd", "måne", "horn", "mun", "sten", "näbb", "hjärta", "lock", "väv"
        ]
    
    
    
    
    let mediumLetterWordList = [
        "mjölkig", "hästig", "skoljan", "hundrad", "blomman", "släppa", "målning", "väsning", "rörlig",
        "skruvad", "älgarna", "hyllan", "trädet", "kusten", "skalan", "tjuvakt", "skapad", "spegeln", "skurkarna",
        "skruvna", "stjälpa", "hängare", "knappen", "polisens", "väskor", "kläder", "tacken", "duschen", "lampa",
        "mjölkig", "raketen", "pistol", "löstag", "hästig", "fladdra", "soppa", "handtag", "nässlor", "fågeln",
        "fönster", "skolja", "hängare", "klaffen", "skrivet", "cyklop", "väskan", "soffan", "bandet", "löstag"
    ]
    
    

    let hardLetterWordList = [
        "äventyrar", "bekräftad", "diskussion", "förankrar", "genererar", "gratulerar", "installation", "kraftfullt", "motgångar",
        "organisera", "platserna", "presentation", "restaurang", "samhällena", "tillsammans", "underlaget", "valfrihet", "arbetsplats", "berättare",
        "betonar", "eleverna", "förstärka", "gällande", "hjälplös", "inredning", "kompisar", "lyckades", "motstånd", "omständig",
        "översätt", "producent", "reklamfil", "skådespel", "stegvis", "tacksamma", "undersöka", "vårtermin", "årligen", "ännu", "belysa",
        "björnbär", "energisk", "förenkla", "gällande", "invånare", "övertyga", "poängtera", "tydligare", "upptäckt"
    ]
    
    
    
    
    
    func generateWord (difficulty: Difficulty) -> String? {
        switch difficulty {
        case .easy :
            return easyLetterWordList.randomElement()
        
        case .medium :
            return mediumLetterWordList.randomElement()
            
        case .hard:
            return hardLetterWordList.randomElement()
        }
        
        
        
    }
    
    
}

enum Difficulty: String {
    case easy = "Lätt"
    case medium = "Medium"
    case hard = "Svår"
    
}
