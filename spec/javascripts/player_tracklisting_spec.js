describe("Player", function() {
   beforeEach(function(){
      loadFixtures("tracklisting.html");
      $("#tracklisting").robodisco();
      $lastTrack = $(".track:last");
    });


  describe("findVideos", function(){
    it("makes an ajax request", function(){
      spyOn(jQuery, "ajax");
      helpers.findVideos();
      expect(jQuery.ajax).toHaveBeenCalled();
    });  

  });
    
  describe("clicking on a track", function(){
    it("adds class of next to track", function(){
      $lastTrack.click();
      expect($lastTrack).toHaveClass("next");
    });
   
  }); 
});