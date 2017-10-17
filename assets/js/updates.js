import socket from "./socket"

var chan = {}
function joinChannel(user_id) {
  chan = socket.channel("updates:" + user_id);
  chan.join()
    .receive("ok", resp => { console.log("Joined successfully", resp); })
    .receive("error", resp => { console.log("Unable to join", resp); });

  chan.on("update", updateReceived)
}

function updateReceived(msg) {
	const username = msg.username
	const message = msg.message
	const message_id = msg.message_id
	const user_id = msg.user_id
	const template = `<div class="card mt-4">
      								<div class="card-body">
        								<h4 class="card-title">${username}</h4>
        								<p class="card-text">${message}</p>
        								<div class="likes" data-message_id="${message_id}" data-user_id="${user_id}"><img src="/images/unliked.png" width="32px" height="32px" class="clickable"/></div>
      								</div>
      							</div>
      							`
  $('#messages').append($(template))
}

function init() {
	joinChannel(cfg.user_id)
}

function newMessage() {
	 chan.push("new_message", {user_id:user_id})
}

init()
