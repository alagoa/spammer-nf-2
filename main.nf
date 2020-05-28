
numberRepetitionsForProcessA = params.repsProcessA
numberFilesForProcessA = params.filesProcessA
processAInput = Channel.from([1] * numberRepetitionsForProcessA)

process processA {
	publishDir "${params.output}/${task.hash}", mode: 'copy'

	input:
	val x from processAInput

	output:
	val x into processAOutput
	val x into processCInput
	val x into processDInput
	file "*.txt"

	script:
	"""
	# Simulate the time the processes takes to finish
	timeToWait=\$(shuf -i ${params.processATimeRange} -n 1)
	for i in {1..${numberFilesForProcessA}};
	do echo teste > file_\${i}.txt
	sleep ${params.processATimeBetweenFileCreationInSecs}
	done;
	sleep \$timeToWait
	"""
}
