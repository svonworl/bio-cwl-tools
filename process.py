import sys

# to generate main dockstore.yml
# python process.py `grep -rIl 'class: CommandLineTool' . | grep 'cwl$' | sort | sed 's:\./::'` 
# to find and integrate test files:
# find . -path '*/tests/*' | sort -f | sed 's:^.::' | sed 's/^/      - /'
# integrate by hand

print 'version: 1.2'
print 'tools:'

categoryAndOutput = [];

for fileName in sys.argv[1:]:
        parts = fileName.split('/')
	category = parts[0]
	name = parts[-1].replace('.cwl', '')
        output = []
        output.append('  - subclass: CWL')
        output.append('    primaryDescriptorPath: /' + fileName)
        output.append('    name: ' + name)
	categoryAndOutput.append((category, output))

for category in sorted(list(set([x[0] for x in categoryAndOutput])), key=lambda s: s.lower()):
	print '# ' + category
	for output in [x[1] for x in categoryAndOutput if x[0] == category]:
		for line in output:
			print line
