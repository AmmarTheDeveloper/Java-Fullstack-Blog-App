$(document).ready(function() {
			
			let edit = false;
			
			console.log("working")
			$("#edit-profile-btn").click(function() {
				
				if(edit){
					$("#profile-detail").show();
					$('#profile-edit').hide();
					edit = false;
					$(this).text("Edit");
				}else{
					$("#profile-detail").hide();
					$('#profile-edit').show();
					edit = true;
					$(this).text("Back");
				}
				
			})

})