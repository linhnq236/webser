$( document ).on('turbolinks:load', function() {
 //  function openStream(){
 //    const config = {audio: false, video: true};
 //    return navigator.mediaDevices.getUserMedia(config);
 //  }
 //
 //  function playStream(idVideoTag, stream) {
 //    const video = document.getElementById(idVideoTag);
 //    video.srcObject = stream;
 //    video.muted = false;
 //    video.play();
 //
 //  }
 //
 //  // openStream()
 //  // .then(stream => playStream('localStream', stream));
 //
 //  var peer = new Peer();
 //  peer.on('open', id => $('#my-peer').append(id));
 //
 // // caller
 // $("#btncall").click(function(){
 //   const id = $("#remoteID").val();
 //   openStream()
 //   .then(stream => {
 //     playStream('localStream', stream);
 //     const call = peer.call(id, stream);
 //     call.on('stream', remoteStream => playStream('remoteStream', remoteStream));
 //   })
 // })
 //  // callee
 // peer.on('call', call => {
 //   openStream()
 //   .then(stream => {
 //     call.answer(stream);
 //     playStream('localStream', stream);
 //     call.on('stream', remoteStream => playStream('remoteStream', remoteStream));
 //
 //   })
 // })
})
