extends Node


static var duration = 3.0
static var total_qus_lvl_1 = 30
static var current_lvl = 0
static var user: Users = null

var compoundArray = [
					#["AgCl","Neutral"],
					#["BaCrO[font_size=16]4[/font_size]","Base"],
					#["CCl[font_size=16]4[/font_size]","Neutral"],
					#["HClO[font_size=16]4[/font_size]","Acid"],
					#["CO[font_size=16]2[/font_size]H","Acid"],
					#["HNO[font_size=16]2[/font_size]","Acid"],
					#["C[font_size=16]3[/font_size]H[font_size=16]8[/font_size]","Neutral"],
					#["CH[font_size=16]3[/font_size]COOH","Acid"],
					#["MgC[font_size=16]2[/font_size]O[font_size=16]4[/font_size]","Base"],
					#["HCN","Acid"],
					#["CH[font_size=16]4[/font_size]","Neutral"],
					#["CaCO[font_size=16]3[/font_size]","Base"],
					#["Na[font_size=16]2[/font_size]S","Base"],
					#["K[font_size=16]2[/font_size]SO[font_size=16]3[/font_size]","Base"],
					#["CH[font_size=16]3[/font_size]-NH[font_size=16]2[/font_size]","Base"],
					#["Mg(OH)[font_size=16]2[/font_size]","Base"],
					#["HCl","Acid"],
					#["HNO[font_size=16]3[/font_size]","Acid"],
					#["K[font_size=16]3[/font_size]PO[font_size=16]4[/font_size]","Base"],
					#["KNO[font_size=16]3[/font_size]","Neutral"],
					#["KNO[font_size=16]2[/font_size]","Base"],
					#["NaBr","Neutral"],
					#["KMnO[font_size=16]4[/font_size]","Base"],
					#["Ca(ClO[font_size=16]3[/font_size])[font_size=16]2[/font_size]","Base"],
					#["H[font_size=16]2[/font_size]O","Both"],
					#["CH[font_size=16]3[/font_size]CH[font_size=16]2[/font_size]CH[font_size=16]2[/font_size]COOH","Acid"],
					#["NaF","Base"],
					#["HF","Acid"],
					#["NH[font_size=16]4[/font_size]Cl","Acid"],
					#["NaC[font_size=16]2[/font_size]H[font_size=16]3[/font_size]O[font_size=16]2[/font_size]","Base"],
					#["CH[font_size=16]3[/font_size]NH[font_size=16]3[/font_size]+","Acid"],
					] 
					
var CompoundType = {
	Acid = "Acid",
	Base= "Base",
	Neutral= "Neutral",
	Both= "Both"
}



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
	
func getCurrentUser():
	var auth = Firebase.Auth.auth
	
	print("getCurrentUser...auth:: "+str(auth)+"   has.email:: "+str(auth.has("email")))
	var email= ""
	if (auth.has("email")):
		email =  (auth.email)	
	var userId = ""
	if (auth.has("userid")): 
		userId = auth.userid
	elif	 (auth.localid): 
		userId = auth.localid
	var db = Firebase.Firestore
	var query: FirestoreQuery = FirestoreQuery.new().from("users")
	var query_results = await Firebase.Firestore.query(query)
	
	if query_results.size() > 0:
		for result in query_results:
			print(str(result))
			var doc_name = result['doc_name']
			var document = result["document"]
			var userData = Users.new(doc_name, document)
			print("getCurrentUser.....userData.id: "+str(userData.id) +
			"   userId::"+userId)
			if (userData.id == userId or email == userData.email):
				user = userData
				print("getCurrentUser.....user: "+str(user.first_name))
				break
			#else: 
				#user = null
			
			
	
	

func sendScore(collection_name: String, score: String, level: int):
	
	#query_user_by_email ("jack@jack.com")
	#var collection: FirestoreCollection = Firebase.Firestore.collection(collection_name)
	
	var data: Dictionary = {
			"score": score,
	}
	var auth = Firebase.Auth.auth
	
	print("getCurrentUser.sendscore..auth:: "+str(auth)+"   has.email:: "+str(auth.has("email")))
	var email= ""
	if (auth.has("email")):
		email =  (auth.email)	
	var userId = ""
	if (auth.has("userid")): 
		userId = auth.userid
	elif	 (auth.localid): 
		userId = auth.localid
		
	var db = Firebase.Firestore
	var query: FirestoreQuery = FirestoreQuery.new().from(collection_name)
	var query_results = await Firebase.Firestore.query(query)
	
	
	if query_results.size() > 0:
		for result in query_results:
			print(str(result))
			var doc_name = result['doc_name']
			var document = result["document"]
			var userData = Users.new(doc_name, document)
			
			if (userData.id == userId or email == userData.email):
				
				user = userData
				
				var collection2: FirestoreCollection = Firebase.Firestore.collection(collection_name)
				#var query2: FirestoreQuery = FirestoreQuery.new().from(collection_name)
				#var document2 = await Firebase.Firestore.query(query.get_doc("MSkKBOGzhjVmWssM2t5z6mNAOf33")	)
				##var document2 = await Firebase.Firestore.query(query.get_doc("MSkKBOGzhjVmWssM2t5z6mNAOf33")	)
				#print("highest_score<<<< "+ str(int(user.highest_score_lvl_1)) +"  score: "+str( int(score)))
				if (level == 1) :
					
					if (str(user.highest_score_lvl_1).is_empty() or (int(user.highest_score_lvl_1) < int(score))) :
						var document2 = await collection2.get_doc(userId)
						print("getCurrentUser.sendscore....document2: "+str(document2))
						document2.add_or_update_field("highest_score_lvl_1", score)
						var new_document_update = await collection2.update(document2) 
						print("newdocupdate....."+str(new_document_update))
					else: 
						print("newdocupdate.....notupdated.....")
				#document.add_or_update_field("highest_score", score)
				#var new_document = await query2.document(userId).update(document)
				#var new_document = await query.document(userId).update(dataDict)
				elif (level == 2) :
					
					if (str(user.highest_score_lvl_2).is_empty() or (int(user.highest_score_lvl_2) < int(score))) :
						var document2 = await collection2.get_doc(userId)
						print("document2: "+str(document2))
						document2.add_or_update_field("highest_score_lvl_2", score)
						var new_document_update = await collection2.update(document2) 
						print("newdocupdate....."+str(new_document_update))
					else: 
						print("newdocupdate.....notupdated.....")
				
				print("getCurrentUser.sendscore.final.....userData.id: "+str(userData.id) +
			"   userId::"+userId)
				break
	
	#if (user!=null):
		#print("user>>"+str(user.id))
		#print("user>>"+str(user.email))
		#print("user>>"+str(user.highest_score))
		#user.highest_score = score
		#var document = FirestoreDocument()
		#document.
		#var query: FirestoreQuery = FirestoreQuery.new().from(collection_name)
		
		
	
		
		
	#query.from(collection_name)
	#query.where("email" , email)
#	where("name", OPERATOR.EQUAL, "Matt", OPERATOR.AND)
	#query.from(collection_name).where("email" , FirestoreQuery.OPERATOR.EQUAL , "jack@jack.com")
	
	#var results = await Firebase.Firestore.query(query)
	#print("finduser.results: "+str(results))

	#if results.size() > 0 :
		#for result in results:
			#var doc_name = result['doc_name']
			#var document = result["document"]
			#var question = Questions.new(doc_name, document)
			##shared_data.compoundArray.append([question.formulaValue, question.compoundType])
#
			#print("product_data: "+str(result["document"])+ " user.type: "+str(question.compoundType
			#)+ " user.name:"+ str(question.formulaValue)+
			#"  compundarrSize: "+str(shared_data.compoundArray.size()))
	#var task: FirestoreDocument = await collection.add(userId, data)
	
		
func query_user_by_email(email: String) -> void:
	var query: FirestoreQuery = FirestoreQuery.new()
	
	#var collection: FirestoreCollection = Firebase.Firestore.collection(collection_name)
	
	#query.from("users").collection("MSkKBOGzhjVmWssM2t5z6mNAOf33").where("email", FirestoreQuery.OPERATOR.EQUAL, email)
	print("Query>>>>>>:"+"APICalled")
	#query.from("users")
	#query.where("email", FirestoreQuery.OPERATOR.NOT_EQUAL, email)
	query.from("questions")
	query.where("acid", FirestoreQuery.OPERATOR.EQUAL, "no2")
	
	
	var users = [] 
	
	var results = await Firebase.Firestore.query(query)
	print("Query>>>>>>: "+ str(results))
	
	#if results.error != null:
		#print("Query error: ", results.error)
	#el
	if results.size() == 0:
		print("QueryNo user found with the email: ", email)
	else:
		print("QueryUser found: ", results)
