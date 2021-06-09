from chalice import Chalice

app = Chalice(app_name='md5sum')


@app.route('/{string}')
def index(string):
    from subprocess import Popen, PIPE, STDOUT
    from urllib.parse import unquote
    string = unquote(string, 'utf-8')
    cmd = 'echo -n ' + string + ' | md5sum'
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT)
    output = p.stdout.read()
    return {"msg":cmd,"msg2":output.decode('utf-8')}