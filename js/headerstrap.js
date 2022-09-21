/** START loads the header, please insert in every file **/
$("header").load("header.html", function()
{
  var linkToMe = $('a[href="'+window.location.href.split('/').pop()+'"]').parent();
  linkToMe.addClass('active')
});
$( "a.submenu" ).click(function() 
{
	$( ".menuBar" ).slideToggle( "normal", function() 
	{
// Animation complete.
	});
});
$( "ul li.dropdown a" ).click(function() 
{
$( "ul li.dropdown ul" ).slideToggle( "normal", function() 
	{
// Animation complete.
	});
	$('ul li.dropdown').toggleClass('current');
});