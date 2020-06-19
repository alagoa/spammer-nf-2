
numberRepetitionsForProcessA = params.repsProcessA
numberFilesForProcessA = params.filesProcessA
Channel.from([1] * numberRepetitionsForProcessA).into{ processAInput; processBInput }

process processA {
	publishDir "${params.output}/${task.hash}", mode: 'copy'

	input:
	val x from processAInput

	output:
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
process processB {
	publishDir "${params.output}/${task.hash}", mode: 'copy'

	input:
	val x from processBInput

	output:
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
