$('#google').html(' <span style="color: #0140CA;">G</span><span style="color: #DD1812;">o</span><span style="color: #FCCA03;">o</span><span style="color: #0140CA;">g</span><span style="color: #16A61E;">l</span><span style="color: #DD1812;">e</span> ')

socket = io.connect()
socket.on('upload success', (data) ->
  #console.log(data)
  #socket.emit('my other event', { my: 'data' })
  if data.imgurl and data.imgid
    window.location = 'http://www.google.com/searchbyimage?nota=1&image_url='+encodeURI(data.imgurl)
    #console.log(data.imgid)
    #does not work as google does not allow iframe embedding
    #window.location='/d/'+data.imgid
)

colors = "000000,FFFFFF,000033,000066,000099,0000CC,0000FF,003300,003333,003366,003399,0033CC,0033FF,006600,006633,006666,006699,0066CC,0066FF,009900,009933,009966,009999,0099CC,0099FF,00CC00,00CC33,00CC66,00CC99,00CCCC,00CCFF,00FF00,00FF33,00FF66,00FF99,00FFCC,00FFFF,330000,330033,330066,330099,3300CC,3300FF,333300,333333,333366,333399,3333CC,3333FF,336600,336633,336666,336699,3366CC,3366FF,339900,339933,339966,339999,3399CC,3399FF,33CC00,33CC33,33CC66,33CC99,33CCCC,33CCFF,33FF00,33FF33,33FF66,33FF99,33FFCC,33FFFF,660000,660033,660066,660099,6600CC,6600FF,663300,663333,663366,663399,6633CC,6633FF,666600,666633,666666,666699,6666CC,6666FF,669900,669933,669966,669999,6699CC,6699FF,66CC00,66CC33,66CC66,66CC99,66CCCC,66CCFF,66FF00,66FF33,66FF66,66FF99,66FFCC,66FFFF,990000,990033,990066,990099,9900CC,9900FF,993300,993333,993366,993399,9933CC,9933FF,996600,996633,996666,996699,9966CC,9966FF,999900,999933,999966,999999,9999CC,9999FF,99CC00,99CC33,99CC66,99CC99,99CCCC,99CCFF,99FF00,99FF33,99FF66,99FF99,99FFCC,99FFFF,CC0000,CC0033,CC0066,CC0099,CC00CC,CC00FF,CC3300,CC3333,CC3366,CC3399,CC33CC,CC33FF,CC6600,CC6633,CC6666,CC6699,CC66CC,CC66FF,CC9900,CC9933,CC9966,CC9999,CC99CC,CC99FF,CCCC00,CCCC33,CCCC66,CCCC99,CCCCCC,CCCCFF,CCFF00,CCFF33,CCFF66,CCFF99,CCFFCC,CCFFFF,FF0000,FF0033,FF0066,FF0099,FF00CC,FF00FF,FF3300,FF3333,FF3366,FF3399,FF33CC,FF33FF,FF6600,FF6633,FF6666,FF6699,FF66CC,FF66FF,FF9900,FF9933,FF9966,FF9999,FF99CC,FF99FF,FFCC00,FFCC33,FFCC66,FFCC99,FFCCCC,FFCCFF,FFFF00,FFFF33,FFFF66,FFFF99,FFFFCC,FFFFFF".split(",");

#$('#colors').append("<a class='tool color' href='#searchcanvas' data-color='#FFFFFF' style='background: #FFFFFF; border:1px solid black; width:10;height:1;'>&nbsp;</a> ")
$.each(colors, () ->
  $('#colors').append("<a class='tool color' href='#searchcanvas' data-color='#" + this + "' style='background: #" + this + ";'>&nbsp;</a> ")
)
$.each([3,6,8,10,14,18,24,27,30,33,36,40,45,50], () -> 
  glow = ''
  if this.toString() is "33" then glow = 'glow'
  $('#sizes').append("<a class='tool size "+glow+"' href='#searchcanvas' data-size='" + this + "' style='background: black; height: " + this + "px; width: " + this + "px;'>&nbsp;</a>")
)

$('.size').click((elem)->
  $('.size').each((elem)->
    $(this).removeClass('glow')
  )
  $(this).addClass('glow')
)

$('.color').click((elem)->
  c=$(this).attr('data-color')
  $('.size').css('background', c)
)
#white background
ctx =  $('#searchcanvas').get(0).getContext('2d')
ctx.fillStyle = 'rgb(255,255,255)'

$('#searchcanvas').sketch({defaultColor: "#000"; defaultSize: 33;})

if ((navigator.userAgent.indexOf('mobile') != -1) || (navigator.userAgent.indexOf('Mobile') != -1) || (navigator.userAgent.indexOf('iPad') != -1))
  $('h1').after('''
    <div class="warning">Device not supported! <b>:(</b></div>
    <div class="note">Sadly, there is a redirect bug on the <b>Google</b> website for mobile decives. On the <b>Google Search by Image</b> page, Google <b><i>redirects mobile devices from the result page to the Google homepage</i></b>, so you can not view the result of your search. Sorry. <a href="http://www.google.com/support/forum/p/Web+Search/thread?tid=6c8fda0c0f045f07&hl=en">The bug is already reported to Google.</a> The only workaround is to use a non mobile browser.</div>
  ''')

$('#q').click( ()->
  socket.emit('q', dataurl: $('#searchcanvas').get(0).toDataURL("image/png"))
)


