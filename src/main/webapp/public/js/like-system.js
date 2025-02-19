function like(pid, uid,el) {

	let data = {
		uid, pid,
		operation: "like"
	}
	
	let btn = el;
	let btnContainer = btn.parentElement;

	$.ajax({
		url: "like",
		data,
		success: function(data, textStatus, jqXHR) {
		
			if (data.includes("done")) {
				
				let count = btn.querySelector("#like-count").innerText;
				count++;
				let html = `<a href="#!" id="like-btn"
											onclick="deleteLike(${pid},${uid},this)"
											class="btn btn-light btn-sm"> <i
												class="fa-solid fa-thumbs-up"></i> <span id="like-count">${count}</span>
				</a>`;
				btnContainer.innerHTML = html;

				let msg = data.split("\n")[1]
				Swal.fire({
					title: "Success",
					text: msg,
					icon: "success",
				})

			} else {
				Swal.fire({
					title: "Error",
					text: data,
					icon: "error",
				})
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			Swal.fire({
				title: "Error",
				text: "Something went wrong while liking  the post...",
				icon: "error",
			})
		}
	})

}

function deleteLike(pid, uid,el) {

	let data = {
		uid, pid,
		operation: "deleteLike"
	}

	
	let btn = el;
	console.log(btn)
	let btnContainer = btn.parentElement;
	
	$.ajax({
		url: "like",
		data,
		success: function(data, textStatus, jqXHR) {
			if (data.includes("done")) {
			
				let count =btn.querySelector("#like-count").innerText;
				count--;
				let html = `<a href="#!" id="like-btn" onclick="like(${pid},${uid},this)"
								class="btn btn-outline-light btn-sm"> <i class="fa-solid fa-thumbs-up"></i> <span id="like-count">${count}</span>
								</a>`;
				 btnContainer.innerHTML = html;

				let msg = data.split("\n")[1]
				Swal.fire({
					title: "Success",
					text: msg,
					icon: "success",
				})

			} else {
				Swal.fire({
					title: "Error",
					text: data,
					icon: "error",
				})
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			Swal.fire({
				title: "Error",
				text: "Something went wrong while removing like from  the post...",
				icon: "error",
			})
		}
	})

}