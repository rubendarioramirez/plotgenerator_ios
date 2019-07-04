//
//  UtilityMgr.swift
//  Plot story assistant
//
//  Created by webastral on 11/2/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

 typealias completion = (Bool)->()

class UtilityMgr : NSObject{
    
   
    
    var index : Int = 0
    static var gender : String = ""
    
    static var fireStoreDB: Firestore{
        get{
            return Firestore.firestore()
        }
    }
    
    static var internetString : String{
        get{
            return "No internet connection"
        }
    }
    
    static func LoginUserDecodedDetail()->UserDetailModel{
        let decoder = JSONDecoder()
        var loginData = UserDetailModel()
        if let questionData = UserDefaults.standard.data(forKey: "loginUserDetail"),
            let data = try? decoder.decode(UserDetailModel.self, from: questionData) {
            loginData = data
        }
        return loginData
    }
    
    
    static let topController = UIApplication.topViewController()
    
   static func displayAlertWithCompletion(title:String,message:String,control:[String],completion:@escaping (String)->()){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for str in control{
            let alertAction = UIAlertAction(title: str, style: .default, handler: { (action) in
                completion(str)
            })
            alertController.addAction(alertAction)
        }
        topController?.present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK:- Display alert without completion
    
  static func displayAlert(title:String,message:String,control:[String]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for str in control{
            let alertAction = UIAlertAction(title: str, style: .default, handler: { (action) in
            })
            alertController.addAction(alertAction)
        }
        topController?.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    static let writingPromptBackgroundColor : [UIColor] = [Color.purpleColor,Color.litlDarkColor,Color.DarkPurpleColor,Color.darkBlueColor,Color.BlackColor]
    
    static let WritingPromptArray = ["He didn't tell anyone where he was going.","He opened the letter and quickly threw it in the fire.","The brick in the wall of the old house was loose.","The normally busy street was empty.","The key would no longer open the door.","It was two in the morning as he lay there listening to the sounds.","More people crammed into the stadium.","Five old pennies in a velvet bag.","He ran, faster than he ever believed possible.","Those were screams, but certainly not humans","She waited but nobody came.","High up on top of a green mountain.","It was the first time he holds a gun, but somehow it didn't feel strange.","His glare was harsh as he stared at the boy.","The river was beginning to break it's banks","She wouldn't even have time to pack.","The house looked different with new windows and doors.","The man tried to blend into the darkness, but she could see him.","That wasn't an animal, but a person either.","I'm sure what I saw. I just can’t explain it.","Is not that I don't believe him. It just that I don’t care.","It was dead way before I arrive.","Right now, I'm more afraid of living than dying.","That's not the deal we sign up for. But we had no way to go back.","I never thought I would forgive","I hear them downstairs…","There is something sweet about knowing you're going to die…","True friends don't leave you behind. I guess I wasn't a true friend after all.","I didn't take a Sherlock Holmes to realise that the knife was gone.","I don't believe in angels. Well, I didn't until then…","I don't swear, I do never do. Not even then.","He check around to make sure nobody was watching. Then he put the USB in the pocket…","He looked at his rifle. It was long time since the last time…","Worse than a sunken ship. Is to be the only survivor.","I looked like a flu. We were sure it was a flu. The only problem was that I wasn't.","We were at war, a war we will lose. But you know, we were taught to fight to fight just to stand our ground, victory was a detail.","It was the worst financial crisis I ever saw. And I saw many.","I would have shot him on the spot. Except I got no bullets.","Wait. Is that a flashlight?","I didn't choose this profession. The profession chose me.","Being in Africa at 42 degrees, wasn't the problem. The guy chasing me, certainly was.","Hired as a private investigator. My first big deal and it was a complete misunderstanding.","I would have call the police, except that I was the police, and I have no clue what to do.","The light was fading.","We almost drowned but I didn't care.","It was the first time I drove a truck, and I thought it would be also the last.","The sheriff stare at me for a second. I knew he knew, but neither of us said anything.","That day I missed her for first time.","It wasn't a problem that she left with another women, but it has to be my sister?"]
    
    
    static let heroJouneryHeadingArray = ["Act 1: The Departure","Act 2: Initiation","Act 3: The Return"]
    
    
    static let heroJourneyTitleArray = ["The call to adventure","Refusal of the call","Supernatural Aid","The crossing of the First Threshold"]
    
    static let heroJourneyTitleArray1 = ["Belly of the whale","The road of Trails","The meeting with the Goddess","Woman as Temptress","Atonement with the father","Apotheosis","The Ultimate Boon"]
    
    static let heroJourneyTitleArray2 = ["Refusal of the return","The magic flight","Rescue from without","The crossing of the return threshold","Master of two worlds"]
    
    
    static let heroJourneyDetailArray = ["The hero is presented with a problem, challenge or adventure. The hero must face beginning of change.  This call must be accepted, this can happen willingly,reluctantly, consciously or accidentally","The hero doesn’t accept the call right away. This can happen for all sorts of reasons, such as being unwilling, being in denial or being kept from being able to respond. The hero finds motivation and or opportunity to answer the call.","The hero is now committed to the quest (consciously or unconsciously) and his guide/ helper becomes known. Often, the mentor will present the hero with a talisman or artifact to aid him later in the quest.","The hero crosses into the field of adventure, leaving behind all that is known and stepping into the unknown. Here, the limits, rules and limits are not yet known. There is no going back, this is where the adventure gets going."]
    
    
   static let heroJourneyDetailArray1 = ["The belly of the whale represents the final separation from the known world of the hero. In this stage, he shows willingness to undergo change and adaptation.","This is a series of tests, tasks and ordeals that the hero must undergo in order to begin his transformation. Often the tests occur in threes and the hero usually fails one ore more. Sometimes, the heroes lose their mentor in this stage (e.g. LOTR and Star Wars).","The hero experiences a love that is all-powerful, encompassing and unconditional.","The hero faces temptation (physical or pleasurable) which make lead him to stray from his mission or even abandon it. This temptation does not necessary come from a woman.","The hero confronts the ultimate power in his life. This is the centre point of the story. All previous steps have brought him here and the steps to come move him away.","There is a period of rest, peace and fulfilment before the hero begins his journey home.","The achievement of the goal or quest. The hero gets what he came for."]
    
    static let heroJourneyDetailArray2 = ["The hero may not want to return to the ordinary world.","Sometimes the hero must escape with the artifact he came for (e.g. the holy grail) and others come after him to claim it back. In this case, the journey back can be just as dangerous and full of adventure.","The hero often has (and needs) guides and helpers, sometimes the helpers are the one that need to bring him back to every day life. Especially if the hero has been severely wounded.","Now that he gained all this knowledge and experience, he needs to retain it and integrate it into his human life and or share it with the world.","This step occurs if the hero is a transcendental hero such as Jesus or Buddha. If the hero is human, this may be simply achieving a balance between the material and spiritual world. The hero becomes comfortable and competent in both the inner and outer world."]
    
    static let guideMeHeadingArray = ["Roles","Three-Dimensional characters","How to create character's arcs?","How antagonists are made?"]
    
    static let guideMeTitleArray = ["Typical Character Roles","3D Characters - Lajos Egri","Change Arc - K.M Weiland","The anatomy of the perfect Antagonist"]
    
    static let guideMeDetailArray = ["Picture your story as an engine, it contains gears and cogs that needs to work together for your engine to move. Characters in a story are no different. Each character in your story has to have a role that moves the story forward, from the protagonist to the antogonist, but that's not all. What about the sidekicks? Or the Mentors? Dive in here to learn more about character roles","Every object has three dimensions: depth, height, width. Human beings have an additional three dimensions:physiology; sociology; psychology. Without a knowledge of these three dimensions we cannot appraise a human being. It is not enough, in your study of a man, to know if he is rude, polite, religious, atheistic, moral, degenerate. You must know why","Aristotle wrote that story was all about plot, however today we know that plot is all about how characters react to it. Will Indiana Jones react the same to a betrayal than Scarface? Can we assume that what's exciting for Batman maybe boring for Francis Underwood? Characters in same situations react completely differently\nDive in this section to learn more about how characters react to situations and how they change accordingly","Lajos Egri discuss in his book \"The art of dramatic writing\" the importance of Unity of Opposites. Meaning that if Batman wants order then the Joker wants chaos, if Gandalf wants peace, then Sauron wants war. Unity of opposites refers to the fact that both, the protagonist and the antagonist wants the exactly opposite and that's why they clash. Failing to apply this concept in your antagonist will make him boring or not realistic. Dig in to understand better how a good antagonists are made."]
    
    static let charGuideTypesTitlesArray = ["char_guide_types_titles":["Protagonist","Protagonist's Helper","Sidekick","Guardian","Mentor","Impact","Antagonist","Antagonist's Helper","Skeptic","Obstacle","Goal"],"change_arc_array_titles":["The Positive Arc","The Flat Arc","The Negative Arc"],"lajos_text":[""],"antagonist_guide_array_titles":["Antagonists are the exact opposite of your protagonist","Antagonists are complex","Antagonists are tough opponents","The Antagonist has a strong motive"]]
    
    static let didSelctGuideTypeArray = ["char_guide_types_titles","lajos_text","change_arc_array_titles","antagonist_guide_array_titles"]
    
    static let charGuideTypesDescArray = ["char_guide_types_titles":["It's the main character of the plot, things happen to him. He drives the action from the beginning to the end of the play, for instance. All stories have at least one main protagonist and , generally, this act motivated by his goal.\n","It may be confused with the protagonist, however his role is to assist the protagonist to reach his objectives in the play, nothing else.\n","It doesn't really appears in all the plays however, the sidekick can be seen in many different genres. He is the character that joins and accompany the protagonist on his victories or defeats, he will always help the protagonist on whatever it's needed, from physical to moral support. The sidekick, also is often devoted to the protagonist and will do whatever for him. It may even die.\n","It's not a mandatory character neither the main one, however it shows up in many novels. Is the one that keeps somethings, it guards it (normally something pretty important and related to the protagonist goal) he will behave as an obstacle for the protagonist to reach his goal.\n","Another not mandatory character however very strong when it's present. He is the Yoda of Star Wars, or the priest in Count of Montecristo. A character that will guide and transform the protagonist (The Hero) so he will be ready for the final battle, the one that he will have to fight to reach his objetives.\n","The impact character is a secondary character with a brief show in the scene, but very important. Is about the character that in a given moment of the play, will give the protagonist the final push to keep going; or he may even give him a clue that he can use later (In the climax for instance) to solve something, to find the value he needs, or the clue to find the murder.\n","In the other side of the table, we find a character that it's the exact opposite of the protagonist: The Antagonist or Villain of the story. This doesn't mean that the antagonist is always bad. However he has a complete opposite goal than the protagonist and he will fight till the end to reach it. With this clash of goals is where you find your conflict.\n","Just as the protagonist, the Antagonist can have his helper. Better said, Characters that helps the Antagonist to reach his objectives. These are not mandatory characters, of course, but they can be very useful to create your plot.\n","The skeptic character is the one that doesn't believe in the objectives of the protagonist. We could say, the opposite of the sidekick, he doesn't really put obstacles on the protagonist however he will try to demoralize him.\n","These kind of characters are somehow similar to the Antagonist's helpers however they act more like jokers, characters that will pop up briefly to complicate or deviate the protagonist from his objective.\n","Sometimes the goal of a Protagonist can be another character. For instance, somebody has been kidnapped and the protagonist has to find him. This character if he doesn't have any other function or role in the play, it can be consider the goal\n"],"change_arc_array_titles":["This is the most popular and often the most resonant character arc. The protagonist will start out with varying levels of personal unfulfillment and denial. Over the course of the story, he will be forced to challenge his beliefs about himself and the world, until finally he conquers his inner demons (and, as a result, probably his outer antagonists as well) and ends his arc having changed in a positive way.\n","Many popular stories feature characters who are already essentially complete unto themselves. They’re already heroes and don’t require any noticeable personal growth to gain the inner strength to defeat the external antagonists. These characters experience little to no change over the course of the story, making their arcs static or “flat.” Sometimes these characters are the catalysts for change in the story world around them, so that we find more prominent growth arcs in the minor characters.\n","Negative character arcs offer, arguably, more variations that either of the other arcs. However, at their most basic level, the Negative Arc is just a Change Arc flipped on its head. Instead of a character who grows out of his faults into a better person, the Negative Arc presents a character who ends up in a worse state than that in which he began the story.\n"],"lajos_text":["There is only one realm in which characters defy natural laws and remain the same–the realm of bar writing.\n- Lajos Egri -\n\nA real an compelling character will always have three dimensions, failing to do so, will result in a unrealistic, uncompelling character whose purpose is just to be there as a filler.\nNot all characters have to have three dimensions is true, but at least you have to focus on the main ones.\n\nLajos Egri on his book \"The Art of Dramatic Writing\" wrote down three categories (hence the three dimensions) that your character has to have.\nTake a look below:\n\nPhysiology\n1.Sex\n2.Age\n3.Height &amp; Weight\n4.Colour of hair, eyes, skin\n5.Posture\n6.Appearance: good-looking, over- or underweight, clean, neat, pleasant, untidy. Shape of head, face, limbs.\n7.Defects: deformities, abnormalities, birthmarks. Diseases.\n8.Heredity.\n\nSociology\n1.Class: lower, middle, upper.\n2.Occupation: type of work, hours of work, income, condition of work, union or nonunion, attitude towards organisation, suitability for work.\n3.Education: amount, kind of schools, marks, favourite subjects, poorest subjects, aptitudes.\n4.Home life: parents living, earning power, orphan, parents separated or divorced, parents’ habits, parents’ mental development, parents’ vices, neglect. Character’s marital status.\n5.Religion\n6.Race, nationality\n7.Place in community: leader among friends, clubs, sports.\n8.Political affiliations\n9.Amusements, hobbies: books, newspapers, magazines he reads.\n\nPsychology\n1.Sex life, moral standards\n2.Personal premise, ambition\n3.Frustrations, chief disappointments\n4.Temperament: choleric, easygoing, pessimistic, optimistic.\n5.Attitude towards life: resigned, militant, defeatist.\n6.Complexes: obsessions, inhibitions, superstitions, phobias.\n7.Extrovert, introvert, ambivert.\n8.Abilities: languages, talents.\n9.Qualities: imagination, judgement, taste, poise.\n10.I.Q.\n\n\n"],"antagonist_guide_array_titles":["Quite often in literature, the antagonist is simply the opposite of the hero/protagonist. For example, if your protagonist is brash and hotheaded, then the antagonist is calm and very much in control of their emotions. The contrast between the two helps to create a compelling conflict and makes interactions more interesting.\nBut beware, their opposition is not just in their tactics to reach their goals, it's deeper than that, it goes all the way to their nature, in a way that the ultimate battle among them it's unavoidable since the first line of your story.\n","As tempting as it might be, do not make your antagonist the epitome of evil. Why not? Because it's boring and unrealistic. How many people have you met in your life that are absolutely evil? Probably zero. No matter how wicked someone is, you can always find some redeeming quality in their character.\nGive your antagonist some good qualities and show them in a positive light during some scenes/chapters. This will create a sharp contrast when they inevitably act upon their evil desires and whatever they do will seem even more terrible than it would have if you had portrayed them as a purely evil being.\nTo give your antagonist even more depth, explore their background. Was he once a good person? Had he always have evil tendencies? What happened to him to be so hateful? Adding those layers to your antagonist will allow your reading be also compelled about your antagonist and truly believe your play.\n","There is no play if your antagonist is not at least as strong as your protagonist. In fact, many great plays starts from the other end, it's the protagonist who has to grow their skills in order to match the evil antagonist. Failing to have a powerful antagonist in your play will result in a boring clash and a boring play as there is no actual challenge for the protagonist.Make youre antagonist perform truly despicable actions and if possible you may also want your protagonist to lose a couple of battles before the last one, when he show us how far he went to defeat the antagonist.\n","What's the goal of your antagonist? What is the purpose behind all of the trouble that they are causing? Don't be tempted to explain that their wicked deeds are simply a product of their evil nature. People don't just randomly do bad things. They usually have a reason for their actions. Come up with a strong motivation and your character becomes that much more believable.\n"]]
    
    static let challengeTitleArray = ["Challenge I","Challenge II","Challenge III","Challenge IV","Challenge V","Challenge VI"]
    
    static let challengeDescArray = ["Elevator Challenge","What's the lie?","Backstory - Find the why!","How he looks?","Test the limits.","Coming soon"]

    static let challengeDescLongArray = ["How does your character reacts in a crisis?\nLet's put him on a elevator with a random stranger. It doesn't matter who.\nSuddenly the elevator gets stuck and they're both trap inside.\n How does he reacts? Is he calm? Does he panic?\nTake the time you need to answer.\nThis exercise will allow you to reflect about your character, how he behaves in limit situations.","The Change Arc is all about the Lie Your Character Believes. His life may be horrible, or his life may seem pretty great. But, festering under the surface, is the Lie. In order for your character to evolve in a positive way, he has to start out with something lacking in his life, some reason that makes the change necessary.","Who is your character today is very important, what's his job, what's his passion, etc. Who will he be is the meat of your story. That's what you're telling it. So what about his past? His past is why he is like this. Were his parents divorce? Perhaps his mother was an alcoholic, did his brother died in a tragic accident? Life events shape who we are. Dive in this challenge to fully develop your three-dimensional character.","Lajos Egri said that part of who you are, it's due to how you look. You don't believe it? Imagine your character was paralyzed when he was a kid, because of that he was all day long in his bed, so he couldn't do much as other kids, like playing outside. At the end he spent most of his time reading and learning new stuff. Odd for a normal kid, but the only life your character knew. Will he be different than other adults when he grows up? A bit smarter perhaps? Dive in to discover how your character looks like","If coal and diamonds are basically the same thing, what make the coal so common and the diamond so rare?\n Pressure.\nSame is true in characters, do you want to know if your character is just one more in the crowd or is he the unique hero your story needs? Let's put pressure on him and find out who he really is.","I'm currently working on more challenges. Don't hesitate to contact me with suggestions"]
    
    static let challengeIQuestArray = ["What is his first reaction?","\nWill he wait to be rescued?","\nThe person next to him suddenly panics. Will your character call him down? Will he panic as well?","\nAfter more than an hour trapped in the elevator suddendly there is a slit open. Come, says the voice, but I can take only one\nthe other should wait until more help comes. Will your character goes first?"]
    
    static let challengeIIQuestArray = ["What misconception does your protagonist have about himself or the world?","\nIs the Lie making his life miserable when the story opens? If so, how?","\nIf not, will the Inciting Event and/or the First Plot Point begin to make him uncomfortable as a result of his Lie?","\nWhat are the symptoms of your character’s Lie?"]
    
    static let challengeIIIQuestArray = ["Describe briefly his close family, mother, father, siblings?. Are they all alive? Are the parents divorced? Happy family perhaps?","\nWhat's his best childhood memory?","\nWhat's his worst childhood memory?","\nDid he had any friends when he was a child? How his friends back them will describe him? If he had no friends, why was it?"]
    
     static let challengeIVQuestArray = ["Take a moment to reflect. Jot down 5 adjectives that will describe your character physically","\nDoes he has any birth mark? Tattoos perhaps that will make him unique?","\nThere is any medical condition? Allergies? Something that manifest physically even if he can hide under his clothes?","\nConsider his posture a little bit, can you describe it? Also, what about his appearance? Is he neat? Is he tidy? Will you say he is overall good looking?"]
    
    
    static let challengeVQuestArray = ["How would he react if someone he cares about is in danger?","\nWill he be able to kill? ","\nWill your character say that the end justify the means when it's about protecting a loved one?","\nLet's says he doesn't dare to cross his own limits to save the life a person he cares. What within his limits/boundaries will he do to solve the situation?"]
    
    
    static let combineChallengeQuestArray = [challengeIQuestArray,challengeIIQuestArray,challengeIIIQuestArray,challengeIVQuestArray,challengeVQuestArray]
    
    
    static let genresArray = ["Tragedy","Science fiction","Fantasy","Mythology","Adventure","Mystery","Drama","Romance","Action / Adventure","Satire","Horror","Tragic comedy","Young adult fiction","Dystopia","Action thriller"]
    
    static let maleNameArry = ["James", "John", "Robert", "Michael", "William", "David", "Richard","Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew", "Anthony", "Donald", "Mark", "Paul", "Steven", "Andrew", "Kenneth", "George", "Joshua", "Kevin", "Brian", "Edward", "Ronald", "Timothy", "Jason", "Jeffrey", "Ryan", "Jacob", "Gary", "Nicholas", "Eric", "Stephen", "Jonathan", "Larry","Justin", "Scott", "Brandon","Frank", "Benjamin","Gregory" ,"Raymond" ,"Samuel", "Patrick", "Alexander" ,"Jack", "Santiago", "Sebastián", "Matías", "Mateo", "Nicolás", "Alejandro", "Diego", "Samuel", "Benjamín", "Daniel", "Joaquín", "Lucas", "Tomas", "Gabriel", "Martín", "David", "Emiliano", "Jerónimo", "Emmanuel", "Agustín", "Juan Pablo", "Juan José", "Andrés", "Thiago", "Leonardo", "Felipe", "Ángel", "Maximiliano", "Christopher", "Juan Diego", "Adrián", "Pablo", "Miguel Ángel", "Rodrigo", "Alexander", "Ignacio", "Emilio", "Dylan", "Bruno", "Carlos", "Vicente", "Valentino", "Santino", "Julián", "Juan Sebastián", "Aarón", "Lautaro", "Axel", "Fernando", "Ian", "Christian", "Javier", "Manuel", "Luciano", "Francisco", "Juan David", "Iker", "Facundo", "Rafael", "Alex", "Franco", "Antonio", "Luis", "Isaac", "Máximo", "Pedro", "Ricardo", "Sergio", "Eduardo", "Bautista"]
    
    static let femaleNameArray = ["Mary", "Patricia","Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Margaret", "Karen", "Nancy", "Lisa", "Betty", "Dorothy", "Sandra", "Ashley", "Kimberly", "Donna", "Emily", "Carol", "Michelle", "Amanda", "Melissa", "Deborah", "Stephanie", "Rebecca", "Laura", "Helen", "Sharon", "Cynthia", "Kathleen", "Amy", "Shirley", "Angela", "Anna", "Ruth", "Brenda", "Pamela", "Nicole", "Katherine", "Samantha", "Christine", "Catherine", "Virginia", "Debra", "Rachel", "Janet", "Emma", "Carolyn", "Maria", "Heather", "Diane", "Julie", "Joyce", "Evelyn", "Joan", "Victoria", "Kelly", "Christina", "Lauren", "Frances", "Martha", "Judith", "Cheryl", "Megan", "Andrea", "Olivia", "Ann", "Jean", "Alice", "Jacqueline", "Hannah", "Doris", "Kathryn", "Gloria", "Teresa", "Sara", "Janice", "Marie", "Julia", "Grace", "Judy", "Theresa", "Beverly", "Denise", "Marilyn", "Amber", "Danielle", "Rose", "Brittany", "Diana", "Abigail", "Natalie", "Jane", "Lori", "Alexis", "Tiffany", "Kayla","Sofia","Isabella","Camila","Valentina","Valeria","Mariana","Luciana","Daniela","Gabriela","Victoria","Martina","Lucia","Ximena/Jimena","Sara","Samantha","Maria José","Emma","Catalina","Julieta","Mía","Antonella","Renata","Emilia","Natalia","Zoe","Nicole","Paula","Amanda","María Fernanda","Emily","Antonia","Alejandra","Juana","Andrea","Manuela","Ana Sofia","Guadalupe","Agustina","Elena","María","Bianca","Ariana","Ivanna","Abril", "Florencia", "Carolina", "Maite", "Rafaela"]
    
    
    static let lastNameArray = ["SMITH", "JOHNSON", "WILLIAMS", "JONES", "BROWN", "DAVIS", "MILLER", "WILSON", "MOORE", "TAYLOR", "ANDERSON", "THOMAS", "JACKSON", "WHITE", "HARRIS", "MARTIN", "THOMPSON", "GARCIA", "MARTINEZ", "ROBINSON", "CLARK", "RODRIGUEZ", "LEWIS", "LEE", "WALKER", "HALL", "ALLEN", "YOUNG", "HERNANDEZ", "KING", "WRIGHT", "LOPEZ", "HILL","SCOTT", "GREEN", "ADAMS", "BAKER", "GONZALEZ", "NELSON", "CARTER", "MITCHELL", "PEREZ", "ROBERTS", "TURNER", "PHILLIPS", "CAMPBELL", "PARKER", "EVANS", "EDWARDS", "COLLINS", "STEWART", "SANCHEZ", "MORRIS", "ROGERS", "REED", "COOK", "MORGAN", "BELL", "MURPHY", "BAILEY", "RIVERA", "COOPER", "RICHARDSON","Garcia", "Fernandez", "Lopez", "Martinez", "Gonzalez", "Rodriguez", "Sanchez", "Perez","Martin","Gomez","Ruiz", "Diaz", "Hernandez", "Alvarez", "Jimenez", "Moreno", "Munoz", "Alonso", "Romero", "Navarro", "Gutierrez", "Torres", "Dominguez", "Gil", "Vazquez", "Blanco", "Serrano", "Ramos", "Castro", "Suarez", "Sanz", "Rubio", "Ortega", "Molina", "Delgado", "Ortiz", "Morales", "Ramirez", "Marin", "Iglesias", "Santos", "Castillo", "Garrido"]
    
    static let genderSpinnerArray = ["Male","Female","Transgender"]
    
    static let genderArray = ["Male","Female"]
    
    static let professionArray = ["Retail salespersons","Cashier","Office clerk","Nurse","Waiter","Customer Service representative","Janitor","Cleaner","Secretary","Store clerk","General manager","Operation manager","Auditing clerk","Truck driver","ale representative","Teacher","Teacher assistant","Repair worker","Accountant","Security Guard","Receptionist","Information clerk","Restaurant cook","Housekeeping","Construction laborer","Police officer","Sheriff","Carpenter","Fireman","Merchant","Sailor","Ship Captain","Mechanic","Programmer","IT consultant","Lawyer","Fortune teller","Fast food cook","Electrician","Dish washer","Bartender","Inspector","Tester","Human resource manager","Machinist","Hairdresser","Postal service mail carrier","Dental assistant"]
    
    static let placebirthArray = ["São Paulo - Brazil","Bombay - India","JAKARTA - Indonesia","Karachi - Pakistan","MOSKVA (Moscow) - Russia","Istanbul - Turkey","MEXICO (Mexico City) - Mexico","Shanghai - China","TOKYO - Japan","New York (NY) - USA","BANGKOK - Thailand","BEIJING - China","Delhi - India","LONDON - UK","HongKong - China","CAIRO - Egypt","TEHRAN - Iran","BOGOTA - Colombia","Bandung - Indonesia","Tianjin - China","LIMA - Peru","Rio de Janeiro - Brazil","Lahore - Pakistan","SANTIAGO - Chile","St Petersburg - Russia","Shenyang - China","Calcutta - India","Wuhan - China","Sydney - Australia","Guangzhou - China","SINGAPORE - Singapore","Madras - India","BAGHDAD - Iraq","Pusan - South Korea","Los Angeles (CA) - USA","Yokohama - Japan","DHAKA - Bangladesh","BERLIN - Germany","Alexandria - Egypt","Bangalore - India","Hyderabad - India","Ho Chi Minh City - Vietnam","Hanoi - Vietnam","Haerbin - China","ANKARA - Turkey","BUENOS AIRES - Argentina","Chengdu - China","Ahmedabad - India","Casablanca - Morocco","Chicago (IL) - USA","Xian - China","MADRID - Spain","Barcelona - Spain","PYONGYANG - NorthKorea","Nanjing - China","KINSHASA - Congo (Zaire)","ROMA - Italy","Taipei - Taiwan","Osaka - Japan","KIEV - Ukraine","YANGON - Myanmar","Toronto - Canada","Taegu - South Korea","ADDIS ABABA - Ethopia","Jinan - China","Salvador - Brazil","Inchon - South Korea","Giza - Egypt","Changchun - China","Havanna - Cuba","Nagoya - Japan","Belo Horizonte - Brazil","PARIS - France","TASHKENT - Uzbekistan","Cali - Colombia","Guayaquil - Ecuador","Taiyuan - China","BRASILIA - Brazil","BUCURESTI    - Romania","Faisalabad - Pakistan","Quezon City - Philippines","Houston (TX) - USA","Abidjan - Côte d’Ivorie","Mashhad - Iran","Medellín - Colombia","Kanpur - India","BUDAPEST - Hungary","CARACAS - Venezuela","Prague - Czech Republic"]
    
    static let traitArray = [ "Aware","Ambitious","Altruistic","Candid","Confident","Calm","Brave","Dependable","Determined","Easy-going","Creative","Ethical", "Fair","Devoted","Maternal","Inoccent","Kind","Loving","Selfless","Sincere","Smart","Intelligent","Loyal","Mature","Modest","Patient","Witty","Serious","Fun","Respectful","Responsable","Hardworking","Cheerful","Cautious","Helpful","Open-minded","Obedient","Optimistic","Organized","Social","Strong","Tough","Good leader","Good Friend","Unpredictable"]
    
    static let phrasesArray = [ "Maybe everybody in the whole damn world is scared of each other.","Life is to be lived, not controlled; and humanity is won by continuing to play in face of certain defeat.","Terror made me cruel","We were the people who were not in the papers. We lived in the blank white spaces at the edges of print. It gave us more freedom. We lived in the gaps between the stories.","It sounds plausible enough tonight, but wait until tomorrow. Wait for the common sense of the morning.","It's much better to do good in a way that no one knows anything about it.","Life appears to me too short to be spent in nursing animosity or registering wrongs.","You forget what you want to remember, and you remember what you want to forget.","Finally, from so little sleeping and so much reading, his brain dried up and he went completely out of his mind.","Memories warm you up from the inside. But they also tear you apart.","History, Stephen said, is a nightmare from which I am trying to awake.","It is a great misfortune to be alone, my friends; and it must be believed that solitude can quickly destroy reason.","And meanwhile time goes about its immemorial work of making everyone look and feel like shit.","No man, for any considerable period, can wear one face to himself and another to the multitude, without finally getting bewildered as to which may be the true.","Nowadays people know the price of everything and the value of nothing.","No one forgets the truth; they just get better at lying.","She had waited all her life for something, and it had killed her when it found her.","We need never be ashamed of our tears.","Nothing is so painful to the human mind as a great and sudden change.","It is sometimes an appropriate response to reality to go insane.","It doesn't matter who you are or what you look like, so long as somebody loves you.","I know. I was there. I saw the great void in your soul, and you saw mine.","Perhaps it was freedom itself that choked her.","Anyone who ever gave you confidence, you owe them a lot.","The only lies for which we are truly punished are those we tell ourselves.","I know not all that may be coming, but be it what it will, I’ll go to it laughing."]
    
    
    static let defmomentArray = [ "parents got killed","a big loss","had a trip to a foreing country","got lost","witness a murder","found an artifact","hide a big secret","parents divorced","was bullied at school","had a car accident","had a big accident","was adopted","moved to another city","had no friends","was paralyzed",]
    
    
    static let desireArray = [ "to be loved","to be fear","to be accepted","to be rich","to achieve perfection","to apology","to avoid conflict","to avoid pain","to be acknowledged","to be bad","to be good","to be normal","to be remembered","to be respected","to be someone else","to be special","to be beauty","to be strong","to cheat death","comfort","to face fears","fame","fortune","to find a purpose","to find adventure","to fit in","freedom","independence","to get somewhere","to leave town","glory","revange","justice","knowledge","to not be lonely","power","redemption","to repay a debt","safety","to stand out","to die","to survive"]
    
    static let desireArray1 = ["to be accepted","to be loved","to trust others","to runaway","to be acknowledged","to fight back","to confront fears","to stand his ground","to accept reality","to love his family","to come back home","to find love","to trust again","to be responsable","to grow up","to mature","to push his limits","to stop accepting the status-quo"]
    
     static let bioArray = ["","",""]
    
    static let challengeBioArray = ["The elevator challenge:","The Lie Your Character Believes is the foundation for his character arc. This is what’s wrong in his world. Once you know what’s wrong, you then get to set about figuring out how to make it right.","Backstory Why is your character who he is?","How he looks? In a perfect world, how you look shouldn't affect who you're. But guess what? This is not a perfect world.","When under pressure Your character can react in different ways, how he chooses to act when somebody he loves is in danger?"]
    
    static let challengeQuestionsArray = ["The elevator challenge:":["What will be his first reaction if he gets stuck in a elevator?\n","Will your character wait to be rescued?\n","If the person next to your character has a panic attack. What will happen?\n","Lastly in the eventuality that just one can escape and the other should wait, what will your character do?\n"],"The Lie Your Character Believes":["What misconception does your protagonist have about himself of the world?\n","Is the lie making his life miserable when the story starts? If so, how?\n","If not, will the inciting event make him uncomfortable?\n","What are the symptoms of your character's lie?\n"],"Backstory":["His family\n","Best childhood moment?\n","Worst childhood moment?\n","Did he had any friends? What do they say about him?\n"],"How he looks?":["How your character looks in five words.\n","Birthmarks? Tattoos?\n","Medical conditions? Allergies?\n","About his posture and appearance?\n"],"When under pressure":["How would he react if somebody he loves is in danger?\n","Will he kill?\n","Does he believes that the end justify the means?\n","OK, he doesn't cross his own limits. how does he reacts then?\n"]]
    
    static let challengBioTitleArray = ["The elevator challenge:","The Lie Your Character Believes","Backstory","How he looks?","When under pressure"]
    
    
    
  static func randomNumber(MIN: Int, MAX: Int)-> Int{
        return Int(arc4random_uniform(UInt32(MAX-MIN)) + UInt32(MIN));
    }
    
}

class Color {
    
    static var selectedTextBottomColor:UIColor{
        get{
            return UIColor(red: 253.0/255, green: 85.0/255, blue: 35.0/255, alpha: 1.0)
        }
    }
    
    static var unSelectedTextBottomColor:UIColor{
        get{
            return UIColor(red: 226.0/255, green: 220.0/255, blue: 201.0/255, alpha: 1.0)
        }
    }

   static var purpleColor:UIColor{
        get{
            return UIColor(red: 94.0/255, green: 95.0/255, blue: 139.0/255, alpha: 1.0)
        }
     }
    
   static var litlDarkColor:UIColor{
        get{
            return UIColor(red: 83.0/255, green: 82.0/255, blue: 122.0/255, alpha: 1.0)
        }
    }
    
   static var DarkPurpleColor:UIColor{
        get{
            return UIColor(red: 55.0/255, green: 55.0/255, blue: 83.0/255, alpha: 1.0)
        }
    }
    
   static var darkBlueColor:UIColor{
        get{
            return UIColor(red: 39.0/255, green: 40.0/255, blue: 60.0/255, alpha: 1.0)
        }
    }
    
   static var BlackColor:UIColor{
        get{
            return UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)
        }
    }
    
}



