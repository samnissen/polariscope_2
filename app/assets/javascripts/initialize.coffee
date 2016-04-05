jQuery ->
	$('.scroller').slick({
		dots: true,
		fade: true,
		centerMode: true,
		variableWidth: true,
		slidesToShow: 1,
		slidesToScroll: 1,
		cssEase: 'linear',
		autoplay: true,
		autoplaySpeed: 1500
	})
	$('.scroller').slickLightbox({
		
	})