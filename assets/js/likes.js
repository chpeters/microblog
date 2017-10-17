function fetch_likes(m_id, u_id, element) {
  function success(data, element) {
		if (!$.isEmptyObject(data)) {
			const btn = $('<img src="/images/liked.png" width="32px" height="32px" class="clickable"/>')
			btn.click(() => unlike(data.data.id))
			element.append(btn)
		}
		else {
			const btn = $('<img src="/images/unliked.png" width="32px" height="32px" class="clickable"/>')
			btn.click(() => like(m_id, u_id))
			element.append(btn)
		}

  }

  $.ajax({
    url: "/likes",
    data: {message_id: m_id},
    contentType: "application/json",
    dataType: "json",
    method: "GET",
    success: (data) => success(data, element)
  });
}

function like(m_id, u_id) {
	function success(data) {
		location.reload()
  }

  const data = {	likes: {
  									user_id: u_id,
  									message_id: m_id
  								}
  						}

  $.ajax({
    url: "/likes",
    data: JSON.stringify(data),
    contentType: "application/json",
    dataType: "json",
    beforeSend: function(xhr) {
            xhr.setRequestHeader("X-CSRF-Token", CSRF_TOKEN);
        },
    method: "POST",
    success: success
  });
}

function unlike(l_id) {
	function success(data) {
		location.reload()
  }

  $.ajax({
    url: "/likes/" + l_id,
    contentType: "application/json",
    dataType: "json",
    beforeSend: function(xhr) {
            xhr.setRequestHeader("X-CSRF-Token", CSRF_TOKEN);
        },
    method: "DELETE",
    success: success
  });
}

function run() {
	$(".likes").each(function(i) {
		let m_id = $(this).data('message_id')
		let u_id = $(this).data('user_id')
		let likes = fetch_likes(m_id, u_id, $(this))
	})
}

run()