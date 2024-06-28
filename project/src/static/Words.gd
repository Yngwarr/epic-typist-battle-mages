class_name Words

static func get_words(count: int) -> Array[String]:
	var list : Array[String] = []
	var words_size := words.size()
	for i in count:
		list.append(words[randi_range(0, words_size)])
	return list

static func get_words_with_random_symbols(count: int) -> Array[String]:
	var list : Array[String] = []
	var words_size := words.size()
	for i in count:
		var word := ""
		for j in randi_range(4, 6):
			word += String.chr(randi_range(65, 90)).to_lower()
		list.append(word)
	return list


static var words : Array[String] = [
	"abbey",
	"abide",
	"able",
	"aboard",
	"about",
	"above",
	"abroad",
	"abrupt",
	"absurd",
	"abuse",
	"abused",
	"abuses",
	"accent",
	"accept",
	"access",
	"acquit",
	"acre",
	"acres",
	"across",
	"acted",
	"acting",
	"action",
	"active",
	"actual",
	"adapt",
	"added",
	"adds",
	"adjust",
	"admire",
	"admit",
	"adopt",
	"advice",
	"affair",
	"affect",
	"afford",
	"afraid",
	"africa",
	"after",
	"again",
	"aged",
	"agency",
	"agent",
	"agents",
	"agoand",
	"agree",
	"agreed",
	"ahead",
	"aided",
	"aiding",
	"aimed",
	"aiming",
	"aims",
	"albert",
	"alert",
	"alien",
	"alike",
	"alive",
	"allay",
	"allday",
	"allow",
	"allows",
	"almost",
	"alone",
	"along",
	"aloud",
	"alps",
	"also",
	"alters",
	"always",
	"amazed",
	"amend",
	"ames",
	"among",
	"amount",
	"amused",
	"andrew",
	"angle",
	"animal",
	"anna",
	"annual",
	"answer",
	"anyone",
	"apart",
	"appear",
	"apples",
	"apply",
	"area",
	"argue",
	"arise",
	"arisen",
	"arises",
	"arms",
	"army",
	"arose",
	"around",
	"array",
	"arrest",
	"arthur",
	"arts",
	"ascent",
	"ascii",
	"asia",
	"aside",
	"asis",
	"asked",
	"asking",
	"asks",
	"asseta",
	"assist",
	"assume",
	"atone",
	"attach",
	"attack",
	"attain",
	"attend",
	"aunt",
	"author",
	"avenue",
	"avoid",
	"await",
	"awaken",
	"away",
	"awful",
	"back",
	"badly",
	"bakery",
	"bale",
	"bank",
	"banker",
	"banks",
	"bark",
	"barn",
	"barren",
	"bars",
	"based",
	"basis",
	"baths",
	"battle",
	"bayou",
	"bays",
	"bear",
	"became",
	"become",
	"beds",
	"been",
	"before",
	"began",
	"begin",
	"begins",
	"begun",
	"behalf",
	"behind",
	"being",
	"beings",
	"belong",
	"below",
	"belt",
	"bemen",
	"bench",
	"beside",
	"best",
	"better",
	"beyond",
	"bible",
	"bibles",
	"bill",
	"binary",
	"bind",
	"binds",
	"bird",
	"birds",
	"birth",
	"bishop",
	"bitter",
	"black",
	"blacks",
	"blame",
	"bless",
	"blew",
	"block",
	"blood",
	"blow",
	"bluff",
	"board",
	"bodies",
	"body",
	"boies",
	"boil",
	"boiled",
	"boiler",
	"boley",
	"bolls",
	"bond",
	"book",
	"booker",
	"books",
	"booksi",
	"bored",
	"born",
	"boston",
	"botany",
	"both",
	"bottom",
	"bought",
	"bound",
	"boyd",
	"boyish",
	"boys",
	"branch",
	"brand",
	"brave",
	"breach",
	"break",
	"bred",
	"brick",
	"brief",
	"bright",
	"bring",
	"brings",
	"broad",
	"broke",
	"broken",
	"broker",
	"brooks",
	"brown",
	"bruce",
	"brush",
	"bryce",
	"budget",
	"buff",
	"build",
	"built",
	"bulk",
	"buried",
	"burned",
	"bush",
	"busy",
	"buxton",
	"buying",
	"buys",
	"cabin",
	"cabins",
	"cadets",
	"cakes",
	"call",
	"called",
	"calls",
	"calmly",
	"came",
	"camp",
	"campo",
	"campus",
	"canada",
	"cancer",
	"cannot",
	"capes",
	"capn",
	"capt",
	"card",
	"care",
	"cared",
	"career",
	"caring",
	"carry",
	"carts",
	"carver",
	"case",
	"cases",
	"cash",
	"cast",
	"caste",
	"castle",
	"casual",
	"catch",
	"cattle",
	"cause",
	"caused",
	"causes",
	"cease",
	"ceased",
	"census",
	"cent",
	"centre",
	"cents",
	"chance",
	"change",
	"charge",
	"charm",
	"cheap",
	"check",
	"checks",
	"cheers",
	"cheese",
	"chief",
	"child",
	"china",
	"chinas",
	"choate",
	"choice",
	"choose",
	"chord",
	"chorus",
	"chose",
	"chosen",
	"church",
	"cicero",
	"circle",
	"cities",
	"city",
	"civic",
	"civil",
	"claim",
	"claims",
	"class",
	"clean",
	"clear",
	"clever",
	"close",
	"closed",
	"closer",
	"closet",
	"club",
	"coal",
	"coast",
	"coat",
	"codes",
	"collis",
	"colony",
	"colour",
	"combat",
	"come",
	"comes",
	"coming",
	"commit",
	"common",
	"compel",
	"comply",
	"conan",
	"congo",
	"cook",
	"cooked",
	"cool",
	"coon",
	"coons",
	"copied",
	"copies",
	"copy",
	"corn",
	"corner",
	"cost",
	"costs",
	"cotton",
	"could",
	"count",
	"counts",
	"county",
	"course",
	"court",
	"courts",
	"cover",
	"cows",
	"cracow",
	"cradle",
	"craft",
	"create",
	"credit",
	"creed",
	"crime",
	"crisis",
	"crop",
	"crophe",
	"crops",
	"cross",
	"crowd",
	"crowns",
	"crust",
	"cured",
	"curry",
	"custom",
	"cuts",
	"daily",
	"dairy",
	"damage",
	"danger",
	"danish",
	"dare",
	"dark",
	"data",
	"date",
	"dats",
	"dawned",
	"days",
	"daysi",
	"deacon",
	"dead",
	"deal",
	"dealer",
	"deals",
	"dear",
	"death",
	"debate",
	"debt",
	"debts",
	"decide",
	"deeds",
	"deep",
	"deepen",
	"deeper",
	"deeply",
	"defeat",
	"defect",
	"defend",
	"define",
	"defray",
	"degree",
	"delta",
	"demand",
	"denial",
	"denied",
	"dens",
	"deny",
	"depend",
	"dere",
	"derive",
	"desert",
	"desire",
	"desk",
	"detach",
	"detail",
	"devise",
	"devote",
	"dick",
	"didnt",
	"died",
	"dies",
	"differ",
	"dine",
	"dined",
	"dining",
	"dinner",
	"dipped",
	"direct",
	"dirty",
	"disand",
	"dish",
	"disk",
	"divide",
	"divine",
	"dock",
	"docket",
	"doctor",
	"does",
	"dogs",
	"doing",
	"dollar",
	"dolls",
	"domain",
	"donate",
	"done",
	"donor",
	"donors",
	"dont",
	"door",
	"doors",
	"dotted",
	"double",
	"doubt",
	"down",
	"doyle",
	"dozen",
	"dozens",
	"draw",
	"drawer",
	"drawn",
	"dread",
	"dream",
	"dreary",
	"dress",
	"drink",
	"drinks",
	"drive",
	"driven",
	"driver",
	"drop",
	"drug",
	"ducks",
	"dull",
	"dumas",
	"dumb",
	"during",
	"dust",
	"duties",
	"duty",
	"dying",
	"each",
	"eager",
	"early",
	"earn",
	"earned",
	"earth",
	"ease",
	"easier",
	"easily",
	"east",
	"easy",
	"eaten",
	"eating",
	"ebook",
	"ebooks",
	"edgar",
	"edge",
	"edges",
	"edit",
	"edited",
	"editor",
	"effect",
	"effort",
	"egan",
	"eggs",
	"eight",
	"eighty",
	"either",
	"elders",
	"eldest",
	"elect",
	"eleven",
	"else",
	"email",
	"emmett",
	"empire",
	"employ",
	"enable",
	"ends",
	"enemy",
	"energy",
	"enjoy",
	"enjoys",
	"enlist",
	"enough",
	"enter",
	"entire",
	"entity",
	"envied",
	"equal",
	"erect",
	"errors",
	"escape",
	"essays",
	"eugene",
	"europe",
	"even",
	"events",
	"ever",
	"every",
	"evils",
	"exact",
	"except",
	"excite",
	"excuse",
	"exempt",
	"exert",
	"exist",
	"exists",
	"exodus",
	"expect",
	"expend",
	"expert",
	"extend",
	"extent",
	"eyes",
	"face",
	"faced",
	"faces",
	"facing",
	"fact",
	"facts",
	"failed",
	"fails",
	"fair",
	"fairer",
	"fairly",
	"fairs",
	"faith",
	"fall",
	"fallen",
	"false",
	"family",
	"famous",
	"farm",
	"farmer",
	"farms",
	"fatal",
	"fate",
	"father",
	"fault",
	"faults",
	"favour",
	"fear",
	"feared",
	"feel",
	"feels",
	"fees",
	"feet",
	"fell",
	"fellow",
	"felt",
	"fence",
	"fever",
	"fewer",
	"field",
	"fields",
	"fifth",
	"fifths",
	"fifty",
	"fight",
	"figure",
	"file",
	"files",
	"fill",
	"filled",
	"filthy",
	"final",
	"find",
	"finds",
	"fine",
	"finest",
	"firm",
	"first",
	"fisher",
	"fisk",
	"fitted",
	"five",
	"fixed",
	"flag",
	"flags",
	"float",
	"floor",
	"flower",
	"fodder",
	"folks",
	"follow",
	"folly",
	"fond",
	"font",
	"food",
	"fooled",
	"force",
	"forced",
	"forces",
	"forest",
	"forget",
	"form",
	"formal",
	"format",
	"formed",
	"former",
	"forms",
	"fort",
	"forth",
	"forty",
	"foster",
	"fought",
	"found",
	"four",
	"fourth",
	"fowls",
	"franco",
	"frank",
	"fraud",
	"free",
	"freely",
	"freer",
	"freeze",
	"fresh",
	"friend",
	"frills",
	"frogs",
	"from",
	"front",
	"fuel",
	"full",
	"fully",
	"fund",
	"funds",
	"fusion",
	"futile",
	"future",
	"gain",
	"gained",
	"gains",
	"garden",
	"gather",
	"gave",
	"george",
	"german",
	"gets",
	"giant",
	"gift",
	"gifted",
	"gifts",
	"gill",
	"gills",
	"girl",
	"girls",
	"gist",
	"give",
	"given",
	"gives",
	"giving",
	"glad",
	"gladly",
	"glenn",
	"gloom",
	"gloomy",
	"glory",
	"goal",
	"goals",
	"gods",
	"goes",
	"going",
	"gold",
	"gone",
	"good",
	"goods",
	"gospel",
	"gossip",
	"gotten",
	"govern",
	"grade",
	"grades",
	"grain",
	"grains",
	"grand",
	"grape",
	"grasp",
	"grass",
	"grave",
	"great",
	"greek",
	"grew",
	"grip",
	"gross",
	"ground",
	"group",
	"groups",
	"grove",
	"grow",
	"grown",
	"grows",
	"growth",
	"guard",
	"guest",
	"guests",
	"guide",
	"guided",
	"guilty",
	"gulf",
	"gwine",
	"habit",
	"habits",
	"half",
	"hall",
	"halls",
	"hamper",
	"hand",
	"handed",
	"handle",
	"hands",
	"happen",
	"happy",
	"hard",
	"harder",
	"hardly",
	"harm",
	"harris",
	"harry",
	"hart",
	"hasnt",
	"hatch",
	"hate",
	"hating",
	"hatred",
	"hauled",
	"have",
	"having",
	"head",
	"headed",
	"heaps",
	"hear",
	"heard",
	"hears",
	"heart",
	"hearts",
	"hearty",
	"heath",
	"heaven",
	"hebrew",
	"held",
	"helena",
	"hell",
	"help",
	"helped",
	"helps",
	"henry",
	"herded",
	"here",
	"heroes",
	"herron",
	"hewer",
	"hidden",
	"hide",
	"high",
	"higher",
	"highly",
	"hill",
	"himand",
	"hinds",
	"hire",
	"hired",
	"hogs",
	"hold",
	"holder",
	"holds",
	"holes",
	"holly",
	"holy",
	"home",
	"homes",
	"honest",
	"honor",
	"honour",
	"hope",
	"hoped",
	"horse",
	"horses",
	"hotel",
	"hotels",
	"hour",
	"hours",
	"house",
	"houses",
	"howard",
	"human",
	"humble",
	"humour",
	"hungry",
	"hurt",
	"idea",
	"ideal",
	"ideals",
	"ideas",
	"idol",
	"ignore",
	"images",
	"impart",
	"inch",
	"inches",
	"income",
	"indeed",
	"india",
	"indian",
	"indies",
	"injure",
	"inland",
	"insect",
	"inside",
	"insist",
	"instil",
	"insure",
	"intend",
	"into",
	"invest",
	"invite",
	"iowa",
	"iron",
	"isaiah",
	"island",
	"isnt",
	"israel",
	"issued",
	"issues",
	"italy",
	"items",
	"itno",
	"itself",
	"jacob",
	"jail",
	"james",
	"jamess",
	"jeans",
	"jenny",
	"jobs",
	"john",
	"join",
	"joseph",
	"joshua",
	"judge",
	"jumped",
	"june",
	"jury",
	"just",
	"kansas",
	"keen",
	"keenly",
	"keep",
	"keeps",
	"kept",
	"kettle",
	"kind",
	"kindly",
	"kinds",
	"king",
	"knack",
	"knew",
	"knife",
	"knit",
	"know",
	"known",
	"knows",
	"krause",
	"label",
	"labour",
	"lack",
	"ladies",
	"lady",
	"laid",
	"lain",
	"lake",
	"lakes",
	"land",
	"lapel",
	"large",
	"larger",
	"last",
	"lasts",
	"late",
	"lately",
	"latent",
	"later",
	"latest",
	"latin",
	"latter",
	"laws",
	"laying",
	"lead",
	"leader",
	"leads",
	"league",
	"learn",
	"learns",
	"least",
	"leave",
	"leaves",
	"left",
	"legal",
	"lend",
	"length",
	"less",
	"lesson",
	"letter",
	"level",
	"lewis",
	"liable",
	"lies",
	"lieu",
	"life",
	"lift",
	"light",
	"like",
	"liked",
	"likely",
	"likes",
	"liking",
	"limit",
	"limits",
	"line",
	"lines",
	"linked",
	"links",
	"lips",
	"liquor",
	"list",
	"listen",
	"litany",
	"little",
	"live",
	"lived",
	"lively",
	"lives",
	"living",
	"lloyd",
	"loads",
	"loaned",
	"local",
	"locked",
	"logo",
	"london",
	"long",
	"longer",
	"look",
	"looked",
	"looks",
	"loose",
	"lord",
	"lose",
	"loses",
	"losing",
	"loss",
	"losses",
	"lost",
	"lots",
	"louis",
	"love",
	"loved",
	"lover",
	"loves",
	"lower",
	"lowest",
	"lunch",
	"luther",
	"luxury",
	"lynch",
	"macon",
	"made",
	"mail",
	"main",
	"mainly",
	"major",
	"make",
	"makes",
	"makesa",
	"making",
	"malden",
	"malice",
	"mammy",
	"mana",
	"manly",
	"manner",
	"manone",
	"mans",
	"many",
	"marble",
	"marked",
	"market",
	"marshy",
	"mary",
	"mass",
	"masses",
	"master",
	"matter",
	"mayor",
	"meal",
	"meals",
	"mean",
	"means",
	"meant",
	"medium",
	"meet",
	"meets",
	"mein",
	"member",
	"memory",
	"mend",
	"mens",
	"mental",
	"mere",
	"merely",
	"merits",
	"method",
	"mich",
	"middle",
	"midst",
	"might",
	"mighty",
	"milder",
	"mildly",
	"mile",
	"miles",
	"mill",
	"milton",
	"mind",
	"minds",
	"mine",
	"miner",
	"mines",
	"mingle",
	"minor",
	"minute",
	"miss",
	"misses",
	"mixed",
	"model",
	"modern",
	"modest",
	"modify",
	"moment",
	"money",
	"moneys",
	"month",
	"months",
	"moral",
	"more",
	"morel",
	"morley",
	"morris",
	"moses",
	"most",
	"mostly",
	"mother",
	"motive",
	"moton",
	"motons",
	"motto",
	"mound",
	"mouth",
	"move",
	"moved",
	"moving",
	"much",
	"mules",
	"music",
	"must",
	"myself",
	"name",
	"named",
	"namely",
	"names",
	"naming",
	"napier",
	"narrow",
	"nation",
	"native",
	"nature",
	"near",
	"nearby",
	"nearer",
	"nearly",
	"neat",
	"need",
	"needed",
	"needs",
	"negro",
	"negros",
	"never",
	"newark",
	"newer",
	"newly",
	"news",
	"next",
	"nice",
	"night",
	"nights",
	"nine",
	"noel",
	"noise",
	"noised",
	"none",
	"noon",
	"normal",
	"north",
	"note",
	"noted",
	"notes",
	"nothin",
	"notice",
	"notion",
	"number",
	"nursed",
	"nurses",
	"oath",
	"oats",
	"object",
	"obtain",
	"occupy",
	"occur",
	"oclock",
	"odgen",
	"offer",
	"offers",
	"office",
	"often",
	"ogden",
	"ogdens",
	"ohio",
	"older",
	"oldest",
	"olivet",
	"once",
	"ones",
	"onethe",
	"online",
	"only",
	"open",
	"opened",
	"openly",
	"opera",
	"orator",
	"order",
	"orders",
	"organ",
	"organs",
	"origin",
	"oswald",
	"other",
	"others",
	"ought",
	"ounce",
	"ounces",
	"ours",
	"outer",
	"outset",
	"over",
	"owed",
	"owes",
	"owing",
	"owned",
	"owner",
	"owners",
	"owning",
	"owns",
	"oxen",
	"oxford",
	"page",
	"pages",
	"paid",
	"paint",
	"paper",
	"papers",
	"parade",
	"paris",
	"park",
	"parker",
	"parks",
	"part",
	"partly",
	"parts",
	"partto",
	"party",
	"pass",
	"passed",
	"past",
	"pastor",
	"patch",
	"patent",
	"paused",
	"paying",
	"pays",
	"peace",
	"peep",
	"peking",
	"penny",
	"people",
	"period",
	"permit",
	"person",
	"petty",
	"pglaf",
	"phase",
	"phases",
	"phelps",
	"phrase",
	"pick",
	"picked",
	"picnic",
	"piece",
	"pieces",
	"pies",
	"pigs",
	"piled",
	"pine",
	"pints",
	"pitch",
	"pitied",
	"place",
	"placed",
	"places",
	"plain",
	"plan",
	"plane",
	"plans",
	"plant",
	"plants",
	"play",
	"played",
	"plays",
	"plea",
	"please",
	"plenty",
	"plot",
	"point",
	"points",
	"poland",
	"police",
	"policy",
	"polish",
	"polite",
	"pond",
	"poor",
	"poorer",
	"pork",
	"port",
	"posed",
	"post",
	"posted",
	"potent",
	"pound",
	"pounds",
	"pour",
	"poured",
	"power",
	"powers",
	"prague",
	"praise",
	"pray",
	"preach",
	"prefer",
	"press",
	"pretty",
	"price",
	"pride",
	"prides",
	"priest",
	"prime",
	"print",
	"prints",
	"prior",
	"prize",
	"prizes",
	"prof",
	"profit",
	"proper",
	"proud",
	"prove",
	"proved",
	"public",
	"pulpit",
	"pupils",
	"pure",
	"purely",
	"purest",
	"purity",
	"pursue",
	"push",
	"pushes",
	"puts",
	"quaint",
	"quarts",
	"queen",
	"queens",
	"quest",
	"quick",
	"quiet",
	"quite",
	"quote",
	"quoted",
	"race",
	"races",
	"racial",
	"rain",
	"raise",
	"raised",
	"raises",
	"rally",
	"range",
	"rank",
	"rapid",
	"rare",
	"rarely",
	"rate",
	"rather",
	"reach",
	"read",
	"reader",
	"ready",
	"real",
	"really",
	"realm",
	"reared",
	"reason",
	"rebel",
	"recall",
	"recent",
	"recess",
	"recite",
	"reckon",
	"reduce",
	"refer",
	"reflex",
	"reform",
	"refund",
	"refuse",
	"regard",
	"region",
	"regret",
	"relate",
	"rely",
	"remain",
	"remark",
	"remote",
	"remove",
	"render",
	"rented",
	"reply",
	"report",
	"resign",
	"rest",
	"rests",
	"result",
	"return",
	"reuse",
	"review",
	"revive",
	"rich",
	"riches",
	"ride",
	"right",
	"rights",
	"riis",
	"ring",
	"rink",
	"rise",
	"risen",
	"risher",
	"rising",
	"risk",
	"risked",
	"risks",
	"river",
	"road",
	"roads",
	"robert",
	"robs",
	"rock",
	"rocks",
	"rods",
	"rogers",
	"rolled",
	"roof",
	"room",
	"rooms",
	"rose",
	"roses",
	"rough",
	"round",
	"route",
	"rows",
	"rude",
	"rufus",
	"ruined",
	"rule",
	"ruled",
	"rules",
	"rumour",
	"rural",
	"russa",
	"russia",
	"rust",
	"safe",
	"sage",
	"said",
	"sake",
	"sale",
	"salt",
	"same",
	"samuel",
	"sand",
	"sanest",
	"sates",
	"saving",
	"saying",
	"says",
	"scale",
	"scene",
	"scheme",
	"school",
	"score",
	"scott",
	"sealed",
	"search",
	"seas",
	"season",
	"seat",
	"second",
	"secret",
	"sect",
	"sects",
	"secure",
	"seed",
	"seeing",
	"seek",
	"seeks",
	"seem",
	"seemed",
	"seems",
	"seen",
	"sees",
	"seldom",
	"self",
	"sell",
	"sells",
	"senate",
	"send",
	"sense",
	"sent",
	"sept",
	"sequel",
	"series",
	"sermon",
	"serve",
	"served",
	"seven",
	"sewing",
	"shadow",
	"shake",
	"shall",
	"sham",
	"shape",
	"shapes",
	"share",
	"shared",
	"shares",
	"sheet",
	"sheets",
	"shells",
	"shiny",
	"ship",
	"ships",
	"shoes",
	"shook",
	"shop",
	"shops",
	"short",
	"should",
	"show",
	"showed",
	"shown",
	"shows",
	"sicily",
	"sick",
	"sickly",
	"side",
	"sides",
	"sight",
	"signed",
	"signs",
	"silent",
	"simple",
	"simply",
	"since",
	"singer",
	"single",
	"site",
	"sixty",
	"size",
	"skibo",
	"skill",
	"skins",
	"skip",
	"slave",
	"slaves",
	"sleep",
	"slept",
	"slight",
	"slowly",
	"small",
	"smith",
	"sober",
	"social",
	"soil",
	"soilas",
	"soils",
	"sold",
	"solid",
	"solve",
	"solved",
	"some",
	"songs",
	"sons",
	"soon",
	"sooner",
	"sorry",
	"sort",
	"sorts",
	"sought",
	"soul",
	"souls",
	"sound",
	"source",
	"south",
	"southi",
	"space",
	"spaces",
	"spain",
	"spare",
	"speak",
	"speaks",
	"speech",
	"spend",
	"spends",
	"spent",
	"spile",
	"spirit",
	"spite",
	"spoke",
	"spoken",
	"spoons",
	"spot",
	"spread",
	"spring",
	"sprung",
	"square",
	"stable",
	"staff",
	"stairs",
	"stalk",
	"stalks",
	"stand",
	"stands",
	"star",
	"start",
	"state",
	"stated",
	"states",
	"status",
	"stay",
	"stayed",
	"stead",
	"steady",
	"steam",
	"step",
	"steps",
	"stick",
	"stiff",
	"still",
	"stir",
	"stock",
	"stone",
	"stood",
	"stop",
	"stops",
	"store",
	"stored",
	"stores",
	"storm",
	"story",
	"strata",
	"straw",
	"stream",
	"street",
	"strict",
	"strife",
	"strike",
	"strip",
	"strive",
	"strong",
	"struck",
	"stuck",
	"study",
	"stuffy",
	"stupid",
	"style",
	"styled",
	"such",
	"sudden",
	"suffer",
	"sugar",
	"suited",
	"sultry",
	"summed",
	"summer",
	"sums",
	"sunday",
	"sung",
	"supply",
	"sure",
	"surein",
	"surely",
	"surest",
	"swamp",
	"sweet",
	"swift",
	"sword",
	"sworn",
	"system",
	"table",
	"tables",
	"tact",
	"taft",
	"tail",
	"take",
	"taken",
	"takes",
	"taking",
	"talent",
	"talk",
	"talked",
	"talker",
	"talkin",
	"talks",
	"tall",
	"task",
	"tasks",
	"taste",
	"taught",
	"taxes",
	"teach",
	"team",
	"tear",
	"tears",
	"tell",
	"teller",
	"tells",
	"temper",
	"tenant",
	"tended",
	"tends",
	"tenn",
	"tenth",
	"tenths",
	"term",
	"terms",
	"test",
	"texas",
	"text",
	"texts",
	"thames",
	"than",
	"thank",
	"thanks",
	"that",
	"thats",
	"their",
	"them",
	"theme",
	"themin",
	"then",
	"thence",
	"theory",
	"there",
	"theres",
	"these",
	"they",
	"thick",
	"thing",
	"things",
	"think",
	"thinks",
	"third",
	"thirds",
	"thirty",
	"this",
	"thomas",
	"those",
	"though",
	"three",
	"thrift",
	"throw",
	"thrown",
	"thrust",
	"thus",
	"ticket",
	"tight",
	"tilled",
	"time",
	"timeat",
	"times",
	"timid",
	"tinged",
	"tire",
	"title",
	"today",
	"told",
	"toll",
	"tomb",
	"tone",
	"tongue",
	"took",
	"topic",
	"topics",
	"tops",
	"total",
	"touch",
	"tour",
	"toward",
	"town",
	"towns",
	"trace",
	"track",
	"tracts",
	"trade",
	"trades",
	"train",
	"trains",
	"trait",
	"travel",
	"treat",
	"tree",
	"trees",
	"tried",
	"trip",
	"trips",
	"trough",
	"true",
	"truest",
	"truly",
	"trust",
	"truth",
	"truths",
	"trying",
	"turn",
	"turned",
	"twelve",
	"twenty",
	"twice",
	"type",
	"types",
	"typos",
	"unable",
	"uncle",
	"uncles",
	"under",
	"unfair",
	"unfit",
	"union",
	"unite",
	"united",
	"unjust",
	"unless",
	"unlink",
	"unreal",
	"until",
	"uplift",
	"upon",
	"upward",
	"urban",
	"urged",
	"urging",
	"used",
	"useful",
	"user",
	"using",
	"usual",
	"utica",
	"utmost",
	"utter",
	"vacant",
	"vague",
	"value",
	"vast",
	"vault",
	"vein",
	"verb",
	"very",
	"victim",
	"vienna",
	"view",
	"viewed",
	"views",
	"viii",
	"vile",
	"virus",
	"vise",
	"vision",
	"visit",
	"visits",
	"vital",
	"vivid",
	"vivify",
	"vogue",
	"voice",
	"voices",
	"void",
	"volley",
	"volume",
	"vote",
	"voted",
	"waded",
	"wading",
	"wages",
	"wagon",
	"wagons",
	"wait",
	"waited",
	"walk",
	"walker",
	"walks",
	"wall",
	"walls",
	"wander",
	"want",
	"wanted",
	"wants",
	"wari",
	"warm",
	"warmth",
	"washed",
	"wasnt",
	"waste",
	"wasted",
	"watch",
	"water",
	"waving",
	"ways",
	"weak",
	"wealth",
	"weave",
	"week",
	"weeks",
	"weigh",
	"weight",
	"well",
	"went",
	"were",
	"west",
	"what",
	"whats",
	"when",
	"where",
	"which",
	"while",
	"white",
	"whites",
	"whole",
	"wholly",
	"whom",
	"whose",
	"wide",
	"widely",
	"widen",
	"wider",
	"widest",
	"wife",
	"wild",
	"wildly",
	"will",
	"wilson",
	"wind",
	"wine",
	"wing",
	"wings",
	"wins",
	"winter",
	"wisdom",
	"wise",
	"wish",
	"wished",
	"wishes",
	"with",
	"within",
	"woman",
	"women",
	"womens",
	"wonder",
	"wood",
	"wooden",
	"woods",
	"word",
	"words",
	"work",
	"worked",
	"works",
	"world",
	"worlda",
	"worlds",
	"worms",
	"worn",
	"worse",
	"worst",
	"worth",
	"worthy",
	"would",
	"wound",
	"woven",
	"wrists",
	"write",
	"writer",
	"writes",
	"wrong",
	"wrongs",
	"wrote",
	"yacht",
	"yale",
	"yard",
	"yards",
	"yazoo",
	"year",
	"yearly",
	"years",
	"yellow",
	"york",
	"young",
	"your",
	"yours",
	"youth",
	"zeal",
	"zest",
	"zion"
]
