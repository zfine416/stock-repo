
// console.log('stocks.js loaded')

// $(function(){
// 	stockCollection = new StockCollection();
// 	stockCollectionView = new stockCollectionView(stockCollection);

var $info = $('information');

$(document).ready(function () {
	console.log("test1");
	moveCloud();
	$info.css('left', '440px');
})

$(document).load(function(){
	var halfWidth = $info.width()/2;
	$info.css('left', '440px');
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