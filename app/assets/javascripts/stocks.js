
// console.log('stocks.js loaded')

// $(function(){
// 	stockCollection = new StockCollection();
// 	stockCollectionView = new stockCollectionView(stockCollection);
$(document).ready(function () {
	console.log("test1");
	moveCloud();
	

})

var moveCloud = function(){
	var cloud = $("#cloud");
	$(cloud).animate({"left": $( window ).width()}, 12000, function(){cloud.css("left", -350); moveCloud()});

}




// console.log('stocks.js loaded')

// $(function(){
// 	stockCollection = new StockCollection();
// 	stockCollectionView = new stockCollectionView(stockCollection);

// 	stockCollection.fetch();
// })