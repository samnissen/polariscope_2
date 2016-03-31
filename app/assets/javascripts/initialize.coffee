jQuery ->
	$('.scroller').slick({
		dots: true,
		fade: true,
		centerMode: true,
		centerPadding: '50%',
		variableWidth: true,
		slidesToShow: 1,
		slidesToScroll: 1,
		cssEase: 'linear'
	})