db = db.getMongo().getDB("mac439");

db.fabricantes.insertMany([
{
	"fabricante":"Astro do HW e SW",
	"equipamentos": [
		{"modelo":1001, "tipo":"pc", "preco":799.00, "velocidade":700, "ram":64, "hd":10, "cd":"8x"},
		{"modelo":1002, "tipo":"pc", "preco":2499.00, "velocidade":1500, "ram":128, "hd":60, "cd":"2x"},
		{"modelo":1003, "tipo":"pc", "preco":1999.00, "velocidade":866, "ram":128, "hd":20, "cd":"8x"},
		{"modelo":2004, "tipo":"laptop", "preco":999.00, "tela":12.1, "ram":32, "hd":5},
		{"modelo":2005, "tipo":"laptop", "preco":2399.00, "tela":12.1, "ram":64, "hd":6},
		{"modelo":2006, "tipo":"laptop", "preco":2999.00, "tela":15.7, "ram":96, "hd":20}
	]

},
{
	"fabricante":"Compra Certa",
	"equipamentos": [
		{"modelo":1007, "tipo":"pc", "preco":2299.00, "velocidade":1400, "ram":128, "hd":80, "cd":"2x"},
		{"modelo":1008, "tipo":"pc", "preco":999.00, "velocidade":700, "ram":64, "hd":30, "cd":"4x"},
		{"modelo":2008, "tipo":"laptop", "preco":1249.00, "tela":12.1, "ram":64, "hd":10},
		{"modelo":2009, "tipo":"laptop", "preco":2599.00, "tela":15.1, "ram":256, "hd":20},
		{"modelo":3002, "tipo":"impressora", "preco":267.00, "tipo_impressao":"ink-jet"},
		{"modelo":3003, "tipo":"impressora", "preco":390.00, "tipo_impressao":"laser"},
		{"modelo":3006, "tipo":"impressora", "preco":1999.00, "tipo_impressao":"laser"}
	]

},
{
	"fabricante":"Dinastia HW",
	"equipamentos": [
		{"modelo":1009, "tipo":"pc", "preco":1699.00, "velocidade":1200, "ram":128, "hd":80, "cd":"6x"},
		{"modelo":1010, "tipo":"pc", "preco":699.00, "velocidade":750, "ram":64, "hd":30, "cd":"4x"},
		{"modelo":1011, "tipo":"pc", "preco":1299.00, "velocidade":1100, "ram":128, "hd":60, "cd":"6x"},
		{"modelo":2007, "tipo":"laptop", "preco":3099.00, "tela":15, "ram":128, "hd":20},
	]

},
{
	"fabricante":"Equipa Tudo",
	"equipamentos": [
		{"modelo":1012, "tipo":"pc", "preco":799.00, "velocidade":350, "ram":64, "hd":7, "cd":"8x"},
		{"modelo":1013, "tipo":"pc", "preco":2499.00, "velocidade":753, "ram":256, "hd":60, "cd":"2x"},
		{"modelo":2010, "tipo":"laptop", "preco":1499.00, "tela":12.1, "ram":64, "hd":10}
	]
},
{
	"fabricante":"Bom de Preço",
	"equipamentos": [
		{"modelo":2001, "tipo":"laptop", "preco":1448.00, "tela":12.1, "ram":64, "hd":5},
		{"modelo":2002, "tipo":"laptop", "preco":2584.00, "tela":15.1, "ram":96, "hd":10},
		{"modelo":2003, "tipo":"laptop", "preco":2738.00, "tela":15.1, "ram":64, "hd":10}
	]
},
{
	"fabricante":"First Class HW",
	"equipamentos": [
		{"modelo":3001, "tipo":"impressora", "preco":231.00, "tipo_impressao":"ink-jet"},
		{"modelo":3004, "tipo":"impressora", "preco":439.00, "tipo_impressao":"ink-jet"}
	]
},
{
	"fabricante":"Gambis HW Solutions",
	"equipamentos": [
		{"modelo":3005, "tipo":"impressora", "preco":200.00, "tipo_impressao":"bubble"}
	]
},
{
	"fabricante":"HW House",
	"equipamentos": [
		{"modelo":3007, "tipo":"impressora", "preco":350.00, "tipo_impressao":"laser"}
	]
},
]);
