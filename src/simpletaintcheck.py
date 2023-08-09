import datetime
import sys
import os
import uuid
import shutil
import subprocess
from config import GHIDRA_SCRIPT, HEADLESS_GHIDRA


sys.setrecursionlimit(5000)

def taint_analysis(relpath, output_dir):
    from taint_check.main import taint_stain_analysis
    from taint_check.bug_finder.config import checkcommandinjection, checkbufferoverflow

    global checkcommandinjection, checkbufferoverflow

    script_dir = os.path.dirname(__file__)
    binpath = os.path.join(script_dir, relpath)
    bin = binpath.split("/")[-1]
    print(script_dir)
    print(output_dir)
    ghidra_result_output = os.path.join(script_dir, output_dir, "ghidra_extract_result")
    # ghidra_result = os.path.join(ghidra_result_output, bin, "{}_{}.result".format(bin, "basic_taint"))
    ghidra_result = os.path.join(ghidra_result_output, bin, "{}_{}.result".format(bin, "ref2sink_bof"))

    checkcommandinjection = True
    checkbufferoverflow = True

    print("Starting taint analysis")

    taint_stain_analysis(binpath, ghidra_result, output_dir)

    print("Taint done")



def ghidra_analysis(relpath, keyword, output_dir):
    script_dir = os.path.dirname(__file__)

    ghidra_result_output = os.path.join(script_dir, output_dir, "ghidra_extract_result")
    binpath = os.path.join(script_dir, relpath)

    bin = binpath.split('/')[-1]
    ghidra_project = os.path.join(ghidra_result_output, "ghidra_project")
    if not os.path.isdir(ghidra_project):
        os.makedirs(ghidra_project)

    script = "basic_taint"
    exec_script = os.path.join(GHIDRA_SCRIPT, script + ".py")
    random = uuid.uuid4().hex

    ghidra_rep = os.path.join(ghidra_project, bin + "_" + script) + ".rep"
    bin_ghidra_project = os.path.join(ghidra_result_output, bin)

    if not os.path.isdir(bin_ghidra_project):
        os.makedirs(bin_ghidra_project)

    print("copy {} to {}".format(bin, bin_ghidra_project))
    shutil.copy2(binpath, bin_ghidra_project)

    output_name = os.path.join(bin_ghidra_project, "{}_{}.result".format(bin, script))

    project_name = bin + "_" + script + random

    if keyword is None:
        keyword = "None"
    ghidra_args = [
        HEADLESS_GHIDRA, ghidra_project, project_name,
        '-postscript', exec_script, keyword, output_name,
        '-scriptPath', os.path.dirname(exec_script)
    ]

    if os.path.exists(ghidra_rep):
        ghidra_args += ['-process', os.path.basename(binpath)]
    else:
        ghidra_args += ['-import', "'" + binpath + "'"]

    print("GHIDRA ARGS:\n{}\n".format(ghidra_args))
    p = subprocess.Popen(ghidra_args)
    p.wait()

    shutil.rmtree(ghidra_project)

def main():
    start_time = datetime.datetime.now()


    if len(sys.argv) < 4:
        print("Usage: {} <callgraph/taint/both> <path_to_bin> <output_dir> keyword=None".format(sys.argv[0]))
        sys.exit(-1)

    type = sys.argv[1]
    binpath = sys.argv[2]
    output_dir = sys.argv[3]
    keyword = None
    if len(sys.argv) == 5:
        keyword = sys.argv[4]
    if type == "callgraph" or type == "both":
        ghidra_analysis(binpath, keyword, output_dir)
    if type == "taint" or type == "both":
        taint_analysis(binpath, output_dir)


if __name__ == "__main__":
    main()
