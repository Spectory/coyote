/**
 * @fileOverview
 * A Demo of SpectoPush connection with multiple channels.
 */

$(document).ready(() => {
  const userId = Math.floor(Math.random() * 10000);
  $(`#userId`).html(`I'm user  ${userId}`);

  // Create a Coyote instance.
  const params = {
    url: 'ws://localhost:4000/socket',
    debug: true,
  }
  window.Coyote = new Coyote(params);

  // Define connection event handlers.
  const changeSocketStatus = (status) => $('#socket_status').html(status);

  const connectionCallbacks = {
    onOpen: ev => { changeSocketStatus('open') },
    onError: ev => { changeSocketStatus('error') },
    onClose: e => { changeSocketStatus('closed') },
  };

  // Connect.
  Coyote.connect({}, connectionCallbacks)

  // Define messages callbacks per channel.
  const changeChannelStatus = (channelId, status) => {
    $(`#${channelId}_status`).html(`connected? ${status}`);
  };

  const addMsg = (channelId, msg) => $(`#${channelId}_msgs`).append(`<li class='new-msg'>${msg}</li>`);

  const callbacksFor = (channelId) => {
    return {
      onJoinSucc: (res) => { changeChannelStatus(channelId, true); },
      onJoinFail: (res) => { changeChannelStatus(channelId, false); },
      onMsg: (msg) => { addMsg(channelId, msg.body) },
      onError: e => console.log(`${channelId} error`, e),
      onClose: e => console.log(`${channelId} closed`, e),
    }
  }

  // Join public channels.
  const topic1 = 'public:1';
  const topic2 = 'public:2';
  Coyote.join(topic1, callbacksFor('channel_1'));
  Coyote.join(topic2, callbacksFor('channel_2'));

  // Broadcasts messages at intervals.
  sendMsg = (topic) => {
    Coyote.broadcast(topic, `${userId} Says: Look! a random number: ${Math.random()}`);
  }

  setInterval(sendMsg, 3000, topic1);
  setInterval(sendMsg, 5000, topic2);
});
