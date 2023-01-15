.data
msg0:	.asciiz "------------------------------------------------------------------------------------------------------------------\n"
msg1:	.asciiz "\t\t  Choose the Souaces\n"
soMenu:	.asciiz "1. CHOCOLATE SOUACE\n2. HONEY SOUACE\n3. CRAMEL SOUACE\n4. PISTATIO SOUACE\n5. No Souse\nEnter the Choice No: "
toMenu:	.asciiz "1. STRAWBRRY\n2. BANANA\n3. NUTS\n4. No Addings\nEnter the Choice No: "
msg2:	.asciiz "\t\t Choose the Toppings\n"
msg3:	.asciiz "\tWelcome to Waffle&Pancake Sweets System\n"
msg4:	.asciiz "Enter your name: "
mMenu:	.asciiz "1. for Waffles\n2. for pancakes\n3. for Exit program\nEnter your choice: "
msg5:	.asciiz "Enter the number of Pieces: "
msg6:	.asciiz "Sorry! worng input, Eitting program\n"
msg7:	.asciiz "\t\t Your order information            \n"
msg8:	.asciiz "Sweet Type : "
msg9:	.asciiz "\t Number of pieces : "
msg10:	.asciiz "Souace : "
msg11:	.asciiz "\t Topping : "
msg12:	.asciiz "Discount: "
msg13:	.asciiz "%\t\t Tax: 15%\n"
msg14:	.asciiz "Total Price: "
msg15:	.asciiz " SR\n"
msg16:	.asciiz "Program ended, Thank you !\n"
msg17:	.asciiz "Sorry ! wrong input\n"
msg18:	.asciiz " Try again(Y/N)\n"

msg19:	.asciiz "Pancakes"
msg20:	.asciiz "Waffles"
endl:	.asciiz "\n"
choSo:	.asciiz "chocolate souace"
hnSo:	.asciiz "Honey souace"
crSo:	.asciiz "Cramel souace"
peSo:	.asciiz "Pistatio souace"
noAd:	.asciiz "No Addings"

stTo:	.asciiz "Strawberry"
bnTo:	.asciiz "Banana"
nuTo:	.asciiz "Nuts"

souc:	.word	choSo, hnSo, crSo, peSo, noAd
topp:	.word	stTo, bnTo, nuTo, noAd
name:	.space	30
ten:	.double	10.0
five:	.double	5.0
two:	.double	2.0
fif:	.double	15.0
hund:	.double	100.0

.text
main:
do:
	jal	Choices		# call Choices function
	li	$v0, 5		# read choice from user
	syscall		
	move	$t0, $v0	# choice
	beq	$t0, 1, if	# if choice == 1
	beq	$t0, 2, if	# if choice == 2
	beq	$t0, 3, stop	# if choice == 3
	else:
	la	$a0, msg17	# load address of str
	li	$v0, 4		# print str
	syscall
	la	$a0, msg18	# load address of str
	syscall
	li	$v0, 12		# read ch from user
	syscall
	move	$t5, $v0
	la	$a0, endl	# load address of str
	li	$v0, 4		# print str
	syscall
	beq	$t5, 'Y', while	# check if (ch != 'Y')
	j	stop
	j	while		# jump to while
	if:
	la	$a0, msg5	# load address of str
	li	$v0, 4		# print str
	syscall
	li	$v0, 5		# read pieces from user
	syscall		
	move	$t1, $v0	# pieces
	bne	$t0, 1, else1
	if1:
	l.d	$f2, ten	# load 10.0
	mtc1	$t1, $f4	
	cvt.d.w	$f4, $f4
	mul.d	$f6, $f4, $f2	# 10 * pieces
	add.d	$f8, $f8, $f6	# totalPrice += 10 * pieces
	j	goif2
	else1:
	l.d	$f2, five	# load 5.0
	mtc1	$t1, $f4	
	cvt.d.w	$f4, $f4
	mul.d	$f6, $f4, $f2	# 5 * pieces
	add.d	$f8, $f8, $f6	# totalPrice += 5 * pieces
	goif2:
	bne	$t0, 1, else2	# check type is waffle
	ble	$t1, 5, else2	# pieces > 5
	l.d	$f10, ten	# discount = 10
	j	goSouce
	else2:
	bne	$t0, 2, goSouce	# check type is pancake
	ble	$t1, 10, goSouce # pieces > 10
	l.d	$f10, ten	# discount = 10
	goSouce:
	jal	Souaces		# call Souaces function
	li	$v0, 5		# read souceChoice from user
	syscall		
	move	$t2, $v0	# souceChoice
	ble	$t2, $0, wrongSouCho
	bgt	$t2, 5, wrongSouCho
	beq	$t2, 5, noSouc
	l.d	$f4, two	# load 2.0
	add.d	$f8, $f8, $f4	# totalPrice += 2
	j	goTopp
	wrongSouCho:
	la	$a0, msg6	# load address of str
	li	$v0, 4		# print str
	syscall
	j	exit
	noSouc:
	goTopp:
	jal	Topping		# call Topping function
	li	$v0, 5		# read souceChoice from user
	syscall		
	move	$t3, $v0	# toppingChoice
	ble	$t3, $0, wrongTopCho
	bgt	$t3, 4, wrongTopCho
	beq	$t3, 4, noTopp
	l.d	$f4, five	# load 5.0
	add.d	$f8, $f8, $f4	# totalPrice += 5
	j	goForOrderInfo
	wrongTopCho:
	la	$a0, msg6	# load address of str
	li	$v0, 4		# print str
	syscall
	j	exit
	noTopp:
	goForOrderInfo:
	la	$a0, msg0	# load address of str
	li	$v0, 4		# print str
	syscall
	la	$a0, msg7	# load address of str
	syscall
	la	$a0, msg0	# load address of str
	syscall
	la	$a0, msg8	# load address of str
	syscall
	beq	$t0, 1, typWaff
	la	$a0, msg19	# load address of str
	li	$v0, 4		# print str
	syscall
	j	numPie
	typWaff:
	la	$a0, msg20	# load address of str
	li	$v0, 4		# print str
	syscall
	numPie:
	la	$a0, msg9	# load address of str
	li	$v0, 4		# print str
	syscall
	li	$v0, 1		# print piece
	move	$a0, $t1
	syscall
	la	$a0, endl	# load address of str
	li	$v0, 4		# print str
	syscall
	
	la	$a0, msg10	# load address of str
	li	$v0, 4		# print str
	syscall
	addi	$t8, $t2, -1
	sll	$t8, $t8, 2
	lw	$a0, souc($t8)	# print souaceType
	li	$v0, 4		# print str
	syscall
	la	$a0, msg11	# load address of str
	li	$v0, 4		# print str
	syscall
	addi	$t8, $t3, -1
	sll	$t8, $t8, 2
	lw	$a0, topp($t8)	# print toppType
	li	$v0, 4		# print str
	syscall
	la	$a0, endl	# load address of str
	li	$v0, 4		# print str
	syscall
	la	$a0, msg12	# load address of str
	li	$v0, 4		# print str
	syscall
	li	$v0, 3		# print double value
	mov.d	$f12, $f10	# print discount
	syscall
	la	$a0, msg13	# load address of str
	li	$v0, 4		# print str
	syscall
	l.d	$f2, fif	# load 15.0
	mul.d	$f12, $f2, $f8	# totalPrice * 15
	l.d	$f2, hund	# load 100.0
	div.d	$f12, $f12, $f2	# tax = (totalPrice * 15 / 100)
	c.eq.d	$f10, $f14	# check discount != 0
	bc1t	ahead
	mul.d	$f16, $f10, $f8	# totalPrice * discount
	l.d	$f2, hund	# load 100.0
	div.d	$f16, $f16, $f2	# discPrice = (totalPrice * discount / 100)
	ahead:
	sub.d	$f18, $f12, $f16 # tax - disPrice
	add.d	$f8, $f8, $f18	 # totalPrice += tax - disPrice 
	la	$a0, msg14	# load address of str
	li	$v0, 4		# print str
	syscall
	li	$v0, 3		# print double value
	mov.d	$f12, $f8	# print totalPrice
	syscall
	la	$a0, msg15	# load address of str
	li	$v0, 4		# print str
	syscall
	j	exit
while:	beq	$0, $0, do	# while(true)
stop:
	la	$a0, msg16	# load address of str
	li	$v0, 4		# print str
	syscall
exit:
li	$v0, 10	# terminate program
syscall

#############################
Choices:
	la	$a0, msg0	# load address of str
	li	$v0, 4		# print str
	syscall
	la	$a0, msg3	# load address of str
	syscall
	la	$a0, msg0	# load address of str
	syscall
	la	$a0, msg4	# load address of str
	syscall
	li	$v0, 8		# read str from user
	li	$a1, 30		# length of str
	la	$a0, name	# address of name
	syscall
	la	$a0, mMenu	# load address of str
	li	$v0, 4		# print str
	syscall
	jr	$ra	# return back
	
#############################
Souaces:
	la	$a0, msg0	# load address of str
	li	$v0, 4		# print str
	syscall
	la	$a0, msg1	# load address of str
	syscall
	la	$a0, msg0	# load address of str
	syscall
	la	$a0, soMenu	# load address of str
	syscall
	jr	$ra	# return back
	

#############################
Topping:
	la	$a0, msg0	# load address of str
	li	$v0, 4		# print str
	syscall
	la	$a0, msg2	# load address of str
	syscall
	la	$a0, msg0	# load address of str
	syscall
	la	$a0, toMenu	# load address of str
	syscall
	jr	$ra	# return back