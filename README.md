# pico-player.js
simple audio stream interface with Web Audio API, Audio Data API or HTMLAudioElement


## demo applications
* [Endless Invention](http://mohayonao.herokuapp.com/invention)
    / markov Inventionen 13 a-moll with a J.S.Bach interface
* [windmills](http://mohayonao.herokuapp.com/windmills)
    / windmill interface 24 poly synthesizer (more [74 poly](http://mohayonao.herokuapp.com/windmills?30), [3 poly](http://mohayonao.herokuapp.com/windmills?80) versions)
* [ONE-LINER-ORCHESTRA](http://mohayonao.herokuapp.com/one-liner-orchestra)
    / algorithmic symphonies with one lines


## how to use
    var player = pico.getplayer();
    console.log(player.PLAYER_TYPE);
    console.log(player.SAMPLERATE);
    console.log(player.CHANNEL);
    console.log(player.STREAM_FULL_SIZE);
    
    var sinetone = (function(freq) {
        var phase = 0.0;
        var phaseStep = freq / player.SAMPLERATE;
        var volume = 0.5;
        return {next: function() {
            var stream = new Float32Array(player.STREAM_FULL_SIZE * player.CHANNEL);
            for (var i = 0; i < stream.length; i++) {
                stream[i] = Math.sin(2 * Math.PI * phase) * volume;
                phase += phaseStep;
            }
            return stream;
        }};
    }(440));
    
    player.play(sinetone);
    
    setTimeout(function() {
        player.stop();
    }, 2000);
