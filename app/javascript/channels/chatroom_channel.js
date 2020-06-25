import consumer from "./consumer";

const initChatroomCable = () => {
  const btnEnvoyer = document.getElementById("envoie");
    btnEnvoyer.scrollDown = btnEnvoyer.scrollHeight;
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
      messagesContainer.insertAdjacentHTML('beforeend', data);
      },
    });
  }
}

export { initChatroomCable }