@GoogleFeud
@Universidad del valle de Guatemala
@Proyecto 3 Assembler
@Saul Contreras 18409
@Michele Benvenuto 
@Este programa representa una copia programada en ARM de la API de Google, Google Feud disponible en
@www.googlefeud.com

.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!,{lr}

	@Round Counter
	MOV r8,#0
	@Score
	MOV r10,#0

Gameloop:

	@Guess Counter
	MOV r9,#3 

	@Print interface
	ADD r8,#1
	LDR r1,=interface
	LDR r1,[r1]
	LDR r2,=questionOrCategories
	LDR r2,[r2]
	LDR r0,=tittle
	bl printf
	LDR r1,=Aone
	LDR r1,[r1]
	LDR r2,=Asix
	LDR r2,[r2]
	LDR r3,=Atwo
	LDR r3,[r3]
	LDR r0,=numbers162
	bl printf
	LDR r1,=Aseven
	LDR r1,[r1]
	LDR r2,=Athree
	LDR r2,[r2]
	LDR r3,=Aeight
	LDR r3,[r3]
	LDR r0,=numbers738
	bl printf
	LDR r1,=Afour
	LDR r1,[r1]
	LDR r2,=Anine
	LDR r2,[r2]
	LDR r3,=Afive
	LDR r3,[r3]
	LDR r0,=numbers495
	bl printf
	LDR r1,=Aten
	LDR r1,[r1]
	LDR r0,=number10
	bl printf
	MOV r1,r8
	MOV r2,r9
	MOV r3,r10
	LDR r0,=lowInterface
	bl printf

	@Ask for user answer 0 for ask a categorie and 1 for a free answer
	LDR r4,=control
	LDR r4,[r4]
	CMP r4,#0
	LDREQ r1,=number
	CMP r4,#0
	LDRNE r1,=answer
	CMP r4,#0
	LDREQ r0,=numberFormat
	CMP r4,#0
	LDRNE r0,=answerFormat
	bl scanf
	
	CMP r4,#0
	@IF different Call subroutine check_answer with r1 as the question, if the aswer is correct it will store in number interface the answer. And it will return the points that the user got. 
	@Then call generate_question, with r1 with the direcction of control that has to be 0, that will set all in the initialInterface
	@if equal call subroutine generate_question that will have in r1 the direcction of control, and in r2 the direcction of the catagorie
	BNE Check
	LDR r7,=compareOne
	@Check all options
	CMP r1,r7
	B asignCulture
	LDR r7,=compareTwo
	CMP r1,r7
	B asignPeople
	LDR r7,=compareThree
	CMP r1,r7
	B asignNames
	LDR r7,=comparetFour
	CMP r1,r7
	B asignQuestions
	LDR r0,=errorFormat
	BL printf
	bl getchar
	B Gameloop
	

asignCulture:
	LDREQ r5,=Culture
	B finally

asignPeople:
	LDREQ r5,=People
	B finally

asignNames:
	LDREQ r5,=Names
	B finally

asignQuestions:
	LDREQ r5,=Questions
	B finally

finally:
	@We change currentCategory memory.
	LDR r4,=currentCategory
	STR r5,[r4,#0]
	@set contol in 1
	MOV r4,#1
	LDR r5,=control
	STR r4,[r5,#0]
	MOV r0,r4
	LDR r3,=AllInterface
	LDR r1,=currentCategory
	LDR r2,=AllInitialInterface
	@Generate Question, and change interface
	BL generate_question
	bl getchar
	B Gameloop

Check:
	@Counter for checkIfAnswerIsCorrect
	MOV r0, #10 
	@The answer of the user 
	LDR r1, =answer 
	LDR r1, [r1]
	@the memory of the question 
	LDR r2, =questionOrCategories
	LDR r2, [r2]
	BL checkIfAnswerIsCorrect
	CMP r9, #0
	MOVEQ r4, #0
	LDR r5,=control
	STR r4,[r5,#0]
	bl getchar
	B Gameloop

	MOV r0,#0
	MOV r3,#0
	ldmfd sp!, {lr}
	bx lr

.data
.align 2

compareOne: .asciz "1"
compareTwo: .asciz "2"
compareThree: .asciz "3"
comparetFour: .asciz "4"

errorFormat: .asciz "Select a valid category"

@These memory location will be helpful to have a control in the interface
@it will be a 0 when we need that the interface show the categories, and a 1 
@when we need that it shows an answer of the given category, using the generate_question subroutines
control: .byte 0

@interface
tittle: .asciz "   _____                   _        ______             _ \n  / ____|                 | |      |  ____|           | |\n | |  __  ___   ___   __ _| | ___  | |__ ___ _   _  __| |\n | | |_ |/ _ \  / _ \  / _` | |/ _ \  |  __/ _  \ | | |/ _` |\n | |__| | (_) | (_) | (_| | |  __/ | | |  __/ |_| | (_| |\n   \_____| \___/  \___/  \__, |_|\___|  |_|   \___| \__,_| \__,_|\n                      __/ |                              \n                     |___/                               \n%s%s"
numbers162: .asciz "\n\n\t\t%s\t\t\t\t%s\n\n\t\t%s"
numbers738: .asciz "\t\t\t\t%s\n\n\t\t%s\t\t\t\t%s"
numbers495: .asciz "\n\n\t\t%s\t\t\t\t%s\n\n\t\t%s"
number10: .asciz  "\t\t\t\t10\n\n\n"
lowInterface: .asciz "\n\tRound:%d\t\tGuesses:%d\tScore:%d\t\t\n"

@These asciz will be replaced %s in the initial interface
one: .asciz "1"
two: .asciz "2"
three: .asciz "3"
four: .asciz "4"
five: .asciz "5"
six: .asciz "6"
seven: .asciz "7"
eight: .asciz "8"
nine: .asciz "9"
ten: .asciz "10"
initialInterface: .asciz "\n\n\t\t\tCHOOSE A CATEGORY"
categories: .asciz "\n\n1.Culture\t2.People\t3.Names\t\t4.Questions\n"

@These asciz will be replaced when a question, on the interface
questioninterface: .asciz "\n\n\t\tHOW DOES GOOGLE AUTOCOMPLETE THIS QUERY?\n\t\t\t"

@These will be helpful to change with subroutine generate_question
interface: .word initialInterface
questionOrCategories: .word categories

@The following will be helpful to autofill the answers that were correct
Aone: .word one
Atwo: .word two
Athree: .word three
Afour: .word four
Afive: .word five
Asix: .word six
Aseven: .word seven
Aeight: .word eight
Anine: .word nine
Aten: .word ten

AllInterface: .word Aone,Atwo,Athree,Afour,Afive,Asix,Aseven,Aeight,Anine,Aten,interface,questionOrCategories
AllInitialInterface: .word one,two,three,four,five,six,seven,eight,nine,ten,initialInterface,categories,questioninterface

@When a number is asked from the user
numberFormat: .asciz "Choose a Category: %d"
number:	.word 0

@When an answer in a string format is asked form the user
answerFormat: .asciz "Answer: %s"
answer: .asciz ""

@Here we store all the data on the memory. Each one has a tag, with this format
@Letter that identifies the category + Question/Answer + Number of the question/answer + (a number that identifies the priority of the answer)

CQuestion1: .asciz "wrestling is"
CAnswer11: .asciz "fake"
CAnswer12: .asciz "real"
CAnswer13: .asciz "forever"
CAnswer14: .asciz "fake gif"
CAnswer15: .asciz "real to me"
CAnswer16: .asciz "life"
CAnswer17: .asciz "wrestling"
CAnswer18: .asciz "dead" 
CAnswer19: .asciz "the hardest sport"
CAnswer10: .asciz "anime"
CultureQuestion1: .word CQuestion1,CAnswer11,CAnswer12,CAnswer13,CAnswer14,CAnswer15,CAnswer16,CAnswer17,CAnswer18,CAnswer19,CAnswer10 

CQuestion2: .asciz "star trek is"
CAnswer21: .asciz "fascist"
CAnswer22: .asciz "better"
CAnswer23: .asciz "a dystopia"
CAnswer24: .asciz "dead"
CAnswer25: .asciz "communist"
CAnswer26: .asciz "real"
CAnswer27: .asciz "bad"
CAnswer28: .asciz "dead" 
CAnswer29: .asciz "just space fantasy"
CAnswer20: .asciz "data dead"
CultureQuestion2: .word CQuestion2,CAnswer21,CAnswer22,CAnswer23,CAnswer24,CAnswer25,CAnswer26,CAnswer27,CAnswer28,CAnswer29,CAnswer20 

CQuestion3: .asciz "app for"
CAnswer31: .asciz "instagram"
CAnswer32: .asciz "facebook"
CAnswer33: .asciz "handyman"
CAnswer34: .asciz "android"
CAnswer35: .asciz "rent"
CAnswer36: .asciz "making friends"
CAnswer37: .asciz "instagram story"
CAnswer38: .asciz "flashlight" 
CAnswer39: .asciz "messenger"
CAnswer30: .asciz "pictures"
CultureQuestion3: .word CQuestion3,CAnswer31,CAnswer32,CAnswer33,CAnswer34,CAnswer35,CAnswer36,CAnswer37,CAnswer38,CAnswer39,CAnswer30 

PQuestion1: .asciz "dad's"
PAnswer11: .asciz "old number"
PAnswer12: .asciz "army"
PAnswer13: .asciz "root beer"
PAnswer14: .asciz "plan"
PAnswer15: .asciz "home"
PAnswer16: .asciz "automotive"
PAnswer17: .asciz "throphy"
PAnswer18: .asciz "back academy" 
PAnswer19: .asciz "birthday"
PAnswer10: .asciz "bullying lesson"
PeopleQuestion1: .word PQuestion1,PAnswer11,PAnswer12,PAnswer13,PAnswer14,PAnswer15,PAnswer16,PAnswer17,PAnswer18,PAnswer19,PAnswer10 

PQuestion2: .asciz "my best friends is a"
PAnswer21: .asciz "monkey"
PAnswer22: .asciz "guy"
PAnswer23: .asciz "bag"
PAnswer24: .asciz "girl"
PAnswer25: .asciz "marine"
PAnswer26: .asciz "robot"
PAnswer27: .asciz "dog"
PAnswer28: .asciz "marine shirt" 
PAnswer29: .asciz "cat"
PAnswer20: .asciz "plastic surgery monster"
PeopleQuestion2: .word PQuestion2,PAnswer21,PAnswer22,PAnswer23,PAnswer24,PAnswer25,PAnswer26,PAnswer27,PAnswer28,PAnswer29,PAnswer20 

PQuestion3: .asciz "my lucky number is"
PAnswer31: .asciz "8 what does it mean"
PAnswer32: .asciz "454"
PAnswer33: .asciz "13"
PAnswer34: .asciz "4"
PAnswer35: .asciz "7"
PAnswer36: .asciz "3"
PAnswer37: .asciz "1"
PAnswer38: .asciz "7 what does it mean" 
PAnswer39: .asciz "6"
PAnswer30: .asciz "5"
PeopleQuestion3: .word PQuestion3,PAnswer31,PAnswer32,PAnswer33,PAnswer34,PAnswer35,PAnswer36,PAnswer37,PAnswer38,PAnswer39,PAnswer30 

NQuestion1: .asciz "brian"
NAnswer11: .asciz "ortega"
NAnswer12: .asciz "mulroney"
NAnswer13: .asciz "mamay"
NAnswer14: .asciz "kemp"
NAnswer15: .asciz "agler"
NAnswer16: .asciz "shaw"
NAnswer17: .asciz "wilson"
NAnswer18: .asciz "banks" 
NAnswer19: .asciz "dozier"
NAnswer10: .asciz "regan"
NamesQuestion1: .word NQuestion1,NAnswer11,NAnswer12,NAnswer13,NAnswer14,NAnswer15,NAnswer16,NAnswer17,NAnswer18,NAnswer19,NAnswer10 

NQuestion2: .asciz "richard"
NAnswer21: .asciz "nixon"
NAnswer22: .asciz "t fields"
NAnswer23: .asciz "madden"
NAnswer24: .asciz "d huffman"
NAnswer25: .asciz "gere"
NAnswer26: .asciz "ramirez"
NAnswer27: .asciz "simmons"
NAnswer28: .asciz "branson" 
NAnswer29: .asciz "sherman"
NAnswer20: .asciz "ojeda"
NamesQuestion2: .word NQuestion2,NAnswer21,NAnswer22,NAnswer23,NAnswer24,NAnswer25,NAnswer26,NAnswer27,NAnswer28,NAnswer29,NAnswer20 

NQuestion3: .asciz "sean"
NAnswer31: .asciz "penn"
NAnswer32: .asciz "mcvay"
NAnswer33: .asciz "hannity"
NAnswer34: .asciz "connery"
NAnswer35: .asciz "mcvay girlfriend"
NAnswer36: .asciz "paul"
NAnswer37: .asciz "kingston"
NAnswer38: .asciz "bean" 
NAnswer39: .asciz "parker"
NAnswer30: .asciz "combs"
NamesQuestion3: .word NQuestion3,NAnswer31,NAnswer32,NAnswer33,NAnswer34,NAnswer35,NAnswer36,NAnswer37,NAnswer38,NAnswer39,NAnswer30 

Questions1: .asciz "what body parts can you"
Answer11: .asciz "sell"
Answer12: .asciz "live without"
Answer13: .asciz "eat"
Answer14: .asciz "donate"
Answer15: .asciz "pierce"
Answer16: .asciz "crack"
Answer17: .asciz "use in soccer"
Answer18: .asciz "fill with bees" 
Answer19: .asciz "donate and still live"
Answer10: .asciz "sprain"
Question1: .word Questions1,Answer11,Answer12,Answer13,Answer14,Answer15,Answer16,Answer17,Answer18,Answer19,Answer10 

Questions2: .asciz "how do you make"
Answer21: .asciz "slime"
Answer22: .asciz "french toast"
Answer23: .asciz "buttermilk"
Answer24: .asciz "brown"
Answer25: .asciz "caramel"
Answer26: .asciz "almond milk"
Answer27: .asciz "gravy"
Answer28: .asciz "meatloaf" 
Answer29: .asciz "whipped cream"
Answer20: .asciz "chili"
Question2: .word Questions2,Answer21,Answer22,Answer23,Answer24,Answer25,Answer26,Answer27,Answer28,Answer29,Answer20 

Questions3: .asciz "can i perform my own"
Answer31: .asciz "wedding"
Answer32: .asciz "marriage"
Answer33: .asciz "nikah"
Answer34: .asciz "home inspection"
Answer35: .asciz "circumcision"
Answer36: .asciz "liposuction"
Answer37: .asciz "membran sweep"
Answer38: .asciz "background check" 
Answer39: .asciz "stretch and sweep"
Answer30: .asciz "tittle search"
Question3: .word Questions3,Answer31,Answer32,Answer33,Answer34,Answer35,Answer36,Answer37,Answer38,Answer39,Answer30 

@Here we store an array with memory directions. Each question has one

Culture: .word CultureQuestion1,CultureQuestion2,CultureQuestion3
People: .word PeopleQuestion1,PeopleQuestion2,PeopleQuestion3
Names: .word NamesQuestion1,NamesQuestion2,NamesQuestion3
Questions: .word Question1,Question2,Question3
currentCategory: .word Culture
