// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function fetch_likes(m_id, u_id, element) {
  function success(data, element) {
  	console.log(JSON.stringify(data))
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
