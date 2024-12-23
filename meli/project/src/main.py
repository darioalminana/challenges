from fastapi import FastAPI
from starlette.responses import RedirectResponse
import subprocess
import psutil

app = FastAPI()

@app.get("/")
def main():
    return RedirectResponse(url="/docs/")

@app.get("/usage_device/{id}")
def usage_device(id:str):
    id2 = "/dev/%s"% id
    for disk in psutil.disk_partitions():
        if disk.device == id2:
            print(disk.mountpoint)
            result = psutil.disk_usage(disk.mountpoint)
            exit
    
    result2 = print("Total percent usage ", result.percent)
    result2 = "Total %0.2f" % (result.percent)
    return {"Device", id2, "message", result2}

@app.get("/usage_all")
def usage_all():
    result = []
    for disk in psutil.disk_partitions():
        if disk.fstype:
            valor = psutil.disk_usage(disk.mountpoint)
            result.append([disk.device, valor.percent])
    return result

@app.get("/runscript")
def run_script():
    try:
        output = subprocess.check_output(['bash', 'script.sh'], stderr=subprocess.STDOUT)
        return {"status": "success", "output": output.decode()}
    except subprocess.CalledProcessError as e:
        raise HTTPException(status_code=500, detail=e.output.decode())