---
mode: "agent"
model: "gpt-4"
tools: ["workspace", "create_file", "run_in_terminal"]
description: "Microsoft security implementation and compliance workflow"
---

# Microsoft Security Implementation Episode Template

## Phase 1: Security Architecture Design
### Identity and Access Management
- Design comprehensive security architecture for BRD development environment
- Implement Microsoft Entra ID integration with proper role assignments
- Configure conditional access policies for location and device-based restrictions
- Set up Privileged Identity Management (PIM) for just-in-time access to production systems
- Enable multi-factor authentication (MFA) for all administrative and development activities
- Design network segmentation and security group configurations

### Azure Security Framework
- Configure Azure Key Vault for secure secrets management
- Implement Private Link for secure service connectivity
- Set up Network Security Groups (NSGs) with minimal required access
- Configure Azure Firewall for advanced threat protection
- Implement managed identities for secure service-to-service communication
- Design backup and disaster recovery security controls

## Phase 2: Data Protection and Governance
### Microsoft Purview Integration
- Implement Microsoft Purview for data cataloging and lineage tracking
- Configure data classification and sensitivity labeling
- Set up data loss prevention (DLP) policies for sensitive BRD information
- Implement automated data discovery and classification
- Configure policy enforcement and compliance monitoring
- Design data retention and disposal policies aligned with compliance requirements

### Information Protection Framework
- Configure Microsoft Information Protection (MIP) labels for document classification
- Implement rights management and encryption for confidential documents
- Set up insider risk management and anomaly detection
- Configure automated policy enforcement and violation detection
- Design data governance workflows and approval processes
- Implement audit logging for all data access and modification activities

## Phase 3: Compliance and Audit Framework
### Regulatory Compliance Implementation
- Implement GDPR compliance framework for data privacy and protection
- Configure HIPAA compliance for healthcare-related BRD projects
- Set up SOX compliance for financial reporting and audit requirements
- Implement ISO 27001 alignment for information security management
- Configure automated compliance assessment and reporting
- Design compliance dashboard and monitoring solutions

### Audit and Monitoring Setup
- Configure comprehensive audit logging for all BRD development activities
- Set up Azure Activity Log monitoring for all resource changes
- Implement application-level audit logging with structured data formats
- Configure Log Analytics workspace for centralized log management and analysis
- Design audit report generation and distribution automation
- Implement compliance monitoring dashboards and alerting

## Phase 4: Security Monitoring and Response
### Security Operations Center (SOC) Setup
- Configure Azure Sentinel for security information and event management (SIEM)
- Set up custom analytics rules for BRD-specific security events
- Implement automated incident response and investigation workflows
- Configure integration with Microsoft 365 Defender for comprehensive threat protection
- Design security incident escalation and notification procedures
- Implement threat intelligence integration and automated threat hunting

### Continuous Security Improvement
- Set up security dashboards and alerting for real-time monitoring
- Design security incident response procedures and communication plans
- Implement automated vulnerability assessment and remediation
- Configure security score tracking and improvement planning
- Design security awareness training and education programs
- Implement continuous security testing and validation procedures

Focus on comprehensive security coverage while maintaining development productivity and regulatory compliance
