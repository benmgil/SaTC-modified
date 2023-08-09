import os

# project path
ROOT_PATH = os.path.split(os.path.abspath(__file__))[0]

# ghidra path
# HEADLESS_GHIDRA = os.path.join("/media/sf_VM_SHARED/ghidra_10.1.2_PUBLIC/", "support", "analyzeHeadless")
HEADLESS_GHIDRA = os.path.join(ROOT_PATH, "..", "SaTC", "ghidra", "support", "analyzeHeadless")
# ghidra script path
GHIDRA_SCRIPT = os.path.join(ROOT_PATH, "headless")

if __name__ == "__main__":
    print(ROOT_PATH)
    print(HEADLESS_GHIDRA)
    print(GHIDRA_SCRIPT)
